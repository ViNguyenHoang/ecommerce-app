const UserRoutes = require("express").Router();
const UserController = require("./../controllers/user_controller");

UserRoutes.post("/signUp", UserController.signUp);
UserRoutes.post("/signIn", UserController.signIn);

module.exports = UserRoutes;
