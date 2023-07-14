import * as ContentController from "../services/content/index.js";
import { ExceptionCodes } from "../utils/exception.js";

export const getContent = async (req, res, next) => {
  ContentController.getContent(res, req.body.loggedInUser, req.query).catch((err) => {
    next(err);
  });
};
