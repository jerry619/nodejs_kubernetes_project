const express = require('express')
const {spawn} = require('child_process');
const app = express();
const port = process.env.PORT || 8080;
const check = spawn('python', ['datacheck.py']);
app.get('/', (req, res) => {
var largeDataSet = [];
 const python = spawn('python', ['script.py']);
 python.stdout.on('data', function (data) {
  console.log('Pipe data from python script ...');
  largeDataSet.push(data);
 });
 python.on('close', (code) => {
 console.log(`child process close all stdio with code ${code}`);
 res.send(largeDataSet.join(""))
 });
})
app.get('/health-check',(req,res)=> {
  res.send ("Health check passed");
});
app.listen(port, () => console.log(` NodeJS app listening on port 
${port}!`))
