const ProductRoutes = require("express").Router();
const ProductController = require("../controllers/product_controller");

ProductRoutes.get("/", ProductController.getAllProducts);
ProductRoutes.get("/:id", ProductController.getProductById);
ProductRoutes.get("/category/:id", ProductController.getProductByCategoryId);
ProductRoutes.post("/", ProductController.createProduct);

module.exports = ProductRoutes;
