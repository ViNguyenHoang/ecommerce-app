const CategoryRoutes = require("express").Router();
const CategoryController = require("../controllers/category_controller");

CategoryRoutes.get("/", CategoryController.getAllCategories);
CategoryRoutes.get("/:id", CategoryController.getCategoryById);
CategoryRoutes.post("/", CategoryController.createCategory);

module.exports = CategoryRoutes;
