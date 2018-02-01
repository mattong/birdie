// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"
import $ from "jquery"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("chirp:feed", {})
let chirpInput = document.querySelector("#chirp_content")
let chirpForm = document.getElementsByClassName("form-group")[0]
let feedContainer = document.querySelector("#feed")
let chirpButton = document.querySelector("#chirp_button")
let chirpUser = document.querySelector("#chirp_current_user")
let chirpUserId = document.querySelector("#chirp_user_id")

chirpButton.addEventListener("click", event => {
    event.preventDefault()
    channel.push("new_chirp", {content: chirpInput.value, author_id: chirpUserId.value})
})

const buildFeed = (chirp) => {
    return(
    `<div class="chirp-box">
       <div class="head">
          <strong class="name"> ${chirp.author} </strong>
          <p class="date"> ${chirp.timestamp} </p>
       </div>
     <p class="chirp"> ${chirp.content} </p>
     </div>`
    )
}

channel.on("new_chirp", payload => {
  console.log(payload)
  let chirpElement = buildFeed(payload)
  chirpInput.value = ""
  $(feedContainer).prepend(chirpElement)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
