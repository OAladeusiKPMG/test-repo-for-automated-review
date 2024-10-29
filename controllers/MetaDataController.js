//References
const express = require("express");
const tb = require("../components/utils/toolbox");
const errorHandler = require("../components/errorHandler");
const jwt = require("jsonwebtoken");
//Models import
const models = require("../server/models/index");
//Instantiations
//Instantiate express router
const router = express.Router();
//other dependencies
//model properties validation
const { body, validationResult } = require("express-validator");
const modelvalidators = require("../middlewares/modelValidators");
//model properties validation

//API endpoint list

// Get all users - no paging
router.get("/getValues", async (req, res, next) => {
  try {
    const functionList = await models.Value.findAll();

    tb.responsify(res, 200, "success", functionList);
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

router.get("/getUnitInFirm", async (req, res, next) => {
  try {
    const functionList = await models.KPMGFunction.findAll();

    tb.responsify(res, 200, "success", { functions: functionList });
  } catch (err) {
    errorHandler.dispatchInternalServerError(res, err);
  }
});

router.get(
  "/getFloorRoomsAndAllSeatsInRoom",
  tb.jwtAuthorize,
  modelvalidators.floorRoomAllSeatsValidator,
  async (req, res, next) => {
    try {
      //validate request properties.
      const modelValidationErrors = validationResult(req);
      if (!modelValidationErrors.isEmpty()) {
        tb.responsify(
          res,
          400,
          await tb.JoinExpressValidatorMessages(modelValidationErrors.array()),
          null
        );
      } else {
        let { floorId, roomId } = req.query;
        floorId = Number(floorId);
        roomId = Number(roomId);
        const rooms = await models.Room.findAll({
          where: { floorId: floorId },
        });
        const allSeatsInRoom = await models.Seat.findAll({
          where: { roomId: roomId },
        });
        tb.responsify(res, 200, "success", {
          rooms: rooms,
          allSeatsInRoom: allSeatsInRoom,
        });
      }
    } catch (err) {
      errorHandler.dispatchInternalServerError(res, err);
    }
  }
);

router.get(
  "/dashboardSummary",
  tb.jwtAuthorize,
  modelvalidators.dateFilterValidator,
  async (req, res, next) => {
    try {
      const modelValidationErrors = validationResult(req);
      if (!modelValidationErrors.isEmpty()) {
        tb.responsify(
          res,
          400,
          await tb.JoinExpressValidatorMessages(modelValidationErrors.array()),
          null
        );
      } else {
        let { from, to } = req.query;
        const self = await models.Reservation.count({ where: { date: [op] } });
      }
    } catch (error) {}
  }
);
//export Router object to make it publicly accessible
module.exports = router;
