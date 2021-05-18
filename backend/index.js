const express = require('express')
const WebSocApi = require('websoc-api')
var app = express()
app.use(express.json())

app.post('/', async (req, res) => {
    try {
        const jsonData = await WebSocApi.callWebSocAPI(req.body);
        res.status(200).send(jsonData)
    } catch (err) {
        res.status(500).json({error: err.message})
    }
})

app.listen(8081, () =>console.log(`Example app listening at port :8081`))



