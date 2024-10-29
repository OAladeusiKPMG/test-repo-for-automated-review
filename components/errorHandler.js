const tb = require("./utils/toolbox");

//return error message as api response
const dispatchCustomError = (res, code, msg, stackTrace) => {
    console.log(stackTrace)
    tb.responsify(res, code, msg, stackTrace);
}

//return internal server error message as api response
const dispatchInternalServerError = (res, stackTrace) => {
    console.log(stackTrace)
    tb.responsify(res, 500, "Some error occurred.Please try again later.", stackTrace);
}

//return bad request error message as api response
const dispatchBadRequestError = (res, msg, stackTrace) => {
    console.log(stackTrace)
    tb.responsify(res, 400, msg, stackTrace);
}

//return not found request error message as api response
const dispatchNotFoundError = (res, msg, stackTrace) => {
    console.log(stackTrace)
    tb.responsify(res, 404, msg, stackTrace);
}

module.exports = { dispatchBadRequestError, dispatchInternalServerError, dispatchCustomError, dispatchNotFoundError }