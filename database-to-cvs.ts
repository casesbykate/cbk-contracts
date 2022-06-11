import fs from "fs";
import database from "./database.json";

(async () => {
    const traitTypes: string[] = [];
    const allAttributes: { [traitType: string]: string }[] = [];
    for (const [id, data] of (database as any).entries()) {
        allAttributes[id] = {};
        for (const attribute of data.attributes) {
            if (traitTypes.includes(attribute.trait_type) !== true) {
                traitTypes.push(attribute.trait_type);
            }
            allAttributes[id][attribute.trait_type] = attribute.value;
        }
    }
    let str = "#id," + traitTypes.join(",") + "\n";
    for (const [id, attributes] of allAttributes.entries()) {
        str += id;
        for (const [index, traitType] of traitTypes.entries()) {
            str += "," + attributes[traitType];
        }
        str += "\n";
    }
    fs.writeFileSync("./database.csv", str);
})();