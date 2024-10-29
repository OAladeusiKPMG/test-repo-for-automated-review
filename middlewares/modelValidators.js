//References

const config = require("../config");

const { body, query, param } = require("express-validator");

const dateFilterValidator = [
  query("from")
    .not()
    .isEmpty()
    .isDate()
    .trim()
    .escape()
    .withMessage("Please specify a vaild date"),
  query("to")
    .not()
    .isEmpty()
    .isDate()
    .trim()
    .escape()
    .withMessage("Please specify a vaild date"),
];
const dateValidator = [
  query("date")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify date."),
  query("officeId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify date."),
];

const floorRoomAllSeatsValidator = [
  query("floorId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify floorId."),
  query("roomId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify roomId."),
];

const getOfficeFloorsValidator = [
  param("officeId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify office."),
];

const getFloorRoomsValidator = [
  param("floorId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify floor."),
];

const getAvailableSeatsValidator = [
  query("date")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify date."),
  query("timeBlock")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify time block."),
  query("roomId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify room."),
];

const createReservationValidator = [
  body("reservationType")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify reservation type."),
  body("reservedForEmail")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage(
      "Please specify the email of the staff reserving the seat as reservedById."
    ),
  body("seatId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please pick a seat."),
  body("officeId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify office."),
  body("date")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify date."),
  body("duration")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify duration."),
  body("timeBlock")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify time block."),
  body("seatNumber")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please pick a seat."),
];

const updateReservationValidator = [
  param("id")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Reservation identifier is required."),
  body("reservationType")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify reservation type."),
  body("reservedForEmail")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage(
      "Please specify the email of the staff reserving the seat as reservedById."
    ),
  body("seatId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please pick a seat."),
  body("date")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify date."),
  body("duration")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify duration."),
  body("timeBlock")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please specify time block."),
  body("seatNumber")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Please pick a seat."),
];

const deleteReservation = [
  query("reservationId")
    .not()
    .isEmpty()
    .trim()
    .escape()
    .withMessage("Reservation identifier is required."),
];

module.exports = {
  dateFilterValidator,
  dateValidator,
  floorRoomAllSeatsValidator,
  getFloorRoomsValidator,
  getOfficeFloorsValidator,
  getAvailableSeatsValidator,
  createReservationValidator,
  updateReservationValidator,
  deleteReservation,
};
