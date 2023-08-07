const OrderRoutes = require("express").Router();
const OrderController = require("../controllers/order_controller");

OrderRoutes.get("/user/:id", OrderController.getOrdersFroUser);
OrderRoutes.post("/", OrderController.createOrder);
OrderRoutes.put("/updateStatus", OrderController.updateOrderStatus);

module.exports = OrderRoutes;
