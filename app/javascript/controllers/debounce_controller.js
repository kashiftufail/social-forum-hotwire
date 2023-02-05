import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  connect() { 
    console.log("debounce controller connected") 
  }

  vote_status(e){
    
    document.getElementById("status").value =  e.target.id;    
  }

  search() {
    
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
        this.formTarget.requestSubmit()
      }, 500)
  }
}
