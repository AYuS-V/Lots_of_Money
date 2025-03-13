const fs = require("fs");
const archiver = require("archiver");
const packageJson = require("../package.json");
const version = packageJson.version || "1.0.0";
const timestamp = new Date().toISOString().replace(/[-T:.Z]/g, "").slice(0, 12);

const zipFileName = `dist/losts-of-money-${timestamp}.zip`;
const output = fs.createWriteStream(zipFileName);

// Delete existing zip files in the dist folder
fs.readdirSync('dist').forEach(file => {
  if (file.endsWith('.zip')) {
    fs.unlinkSync(`dist/${file}`);
  }
});

const archive = archiver("zip", { zlib: { level: 9 } });
output.on("close", () =>
  console.log(`Created ${zipFileName} (${archive.pointer()} bytes)`)
);
archive.on("error", (err) => {
  throw err;
});
archive.pipe(output);
archive.directory("dist/expense_management_app/", false);



archive.finalize();
