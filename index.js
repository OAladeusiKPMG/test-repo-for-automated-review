//references
const dotenv = require("dotenv");
//initialize dotenv to parse .env variables to system environment variables
dotenv.config();
// import process from 'process';
const express = require("express");
var cors = require("cors");
const tb = require("./components/utils/toolbox");
//const jwt = require("jsonwebtoken");
const logger = require("morgan");
const bodyParser = require("body-parser");
//const moment = require("moment");
//for evn variables

const moment = require("moment");

//controllers import
const UserController = require("./controllers/UserController");
const StaffController = require("./controllers/StaffController");
const MetaDataController = require("./controllers/MetaDataController");
const NominationController = require("./controllers/NominationController");

//jobs
const cronJobber = require("./cron_jobs/jobs");
//End of references

//One time instantiations
const app = express();

// body parser and morgan
// Log requests to the console.
app.use(cors());
app.use(logger("dev"));
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
//set static folders to enable direct reading and
// app.use(express.static(__dirname + "/public"));
app.use(express.static(__dirname + "/files"));
//End of one time instantiations

//API route list
app.use("/user", UserController);
app.use("/staff", StaffController);
app.use("/metadata", MetaDataController);
app.use("/nomination", NominationController);

//file downloaders

app.get("/files/cards/:id", function (req, res) {
  const id = req.params.id;
  const file = `${__dirname}/files/cards/${id}`;
  res.download(file); // Set disposition and send it.
});

//cron part
app.get("/test", async (req, res, next) => {
  //testing
  tb.responsify(res, 200, "Success.", null);
});

//execute jobs
cronJobber.RunCorn();

console.log(moment().format("MMM.DD"));

//launch app on port 3000
const port = process.env.PORT;
const port2 = process.env.PORT2;
port5 = process.env.PORT5;
app.listen(port, () => console.log(`server running on port ${port}.`));
