// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})


socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("chirp:feed", {})
let chirpInput = document.querySelector("#chirp_content")
let chirpForm = document.getElementsByClassName("form-gr pfoup")[0]
let feedContainer = document.querySelector("#feed")
let chirpButton = document.querySelector("#chirp_button")

// chirpInput.addEventListener("keypress", event => {
//     if(event.keyCode === 13){
//       channel.push("new_chirp", {body: chirpInput.value})
//       chirpInput.value = ""
//     }
// })

chirpButton.addEventListener("click", event => {
    event.preventDefault()
    $.post("/dashboard", {chirp: {content: chirpInput.value}})
    alert("Yes!")
    channel.push("new_chirp", {body: chirpInput.value})
    chirpInput.value = ""
})

channel.on("new_chirp", payload => {
    let messageItem = document.createElement("div");
    messageItem.innerText = `${payload.body}`
    feedContainer.appendChild(messageItem)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
