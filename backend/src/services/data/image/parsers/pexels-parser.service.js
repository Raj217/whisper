import axios from "axios";
import { ImageSource } from "../../../../models/constants.js";

class PexelsParser {
  static _convertToHex(val) {
    return parseInt(val).toString(16);
  }
  static _rgbToHex(rgb) {
    var hex = "#";
    for (var val of rgb) {
      hex += PexelsParser._convertToHex(val);
    }
    return hex;
  }
  static async parse(data) {
    const { PEXELS_API_BASE_URL } = process.env;
    const images = [];
    for (var item of data.data) {
      const {
        attributes: {
          id,
          user: {
            first_name: publisherFirstName,
            last_name: publisherLastName,
            username: publisherUserName,
          },
          main_color: mainColor,
          tags,
        },
      } = item;
      images.push({
        imageSourceID: id,
        publisherName: `${publisherFirstName} ${publisherLastName}`,
        publisherUrl: `${PEXELS_API_BASE_URL}/@${publisherUserName}`,
        tags: tags,
        color: PexelsParser._rgbToHex(mainColor),
        source: ImageSource.pexels,
        views: 0,
        downloads: 0,
      });
    }
    return images;
  }
}

export default PexelsParser;
