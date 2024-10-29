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


//API endpoint list

// Get all offices - no paging
router.get("/getAllOffices", tb.jwtAuthorize, async (req, res, next) => {
    try {
        const officeList = await models.Office.findAll();
        tb.responsify(res, 200, "success", officeList)
    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});

router.get("/getTest2", async (req, res, next) => {
    try {
        tb.responsify(res, 200, "success", "Hello world!")
    } catch (err) {
        errorHandler.dispatchInternalServerError(res, err)
    }
});

//export Router object to make it publicly accessible
module.exports = router;
