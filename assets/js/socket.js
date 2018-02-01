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
let chirpForm = document.getElementsByClassName("form-group")[0]
let feedContainer = document.querySelector("#feed")
let chirpButton = document.querySelector("#chirp_button")
let chirpUser = document.querySelector("#chirp_current_user")
let chirpUserId = document.querySelector("#chirp_user_id")

chirpButton.addEventListener("click", event => {
    event.preventDefault()
    $.post("/dashboard", {chirp: {content: chirpInput.value, author_id: chirpUserId.value}})
    channel.push("new_chirp", {user: chirpUser.value})
})

const buildFeed = (chirp) => {
    return(
    `<div id="chirp-${chirp.id} class="chirp">
       <div class="row">
         <div class="col-xs-4">
           <strong class="chirp-author"> ${chirp.author} </strong>
           <p> ${chirp.timestamp} </p>
         </div>
       </div>
       <div class="col-xs-12">
         ${chirp.content}
       </div>
     </div>`
    )
}

channel.on("new_chirp", payload => {
    $.get(`/api/${payload.user}`)
      .then( response => {
        $(feedContainer).empty()
        Object.keys(response.chirps).map(function(key, index) {
            const chirpElement = buildFeed(response.chirps[key])
            const chirpHtml = $.parseHTML(chirpElement)
            $(feedContainer).append(chirpHtml)
        })
        chirpInput.value = ""
      })
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
