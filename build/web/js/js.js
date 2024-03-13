document.addEventListener('DOMContentLoaded', () => {
  console.log('ready')
  init()
});

function init() {
   onshowinfo();
}

function onshowinfo(){
    const modalinfo = document.getElementById('modalComent')
    console.log('0')
    if (modalinfo) {
        modalinfo.addEventListener('show.bs.modal', (event) => {
            console.log('1')
            const button = event.relatedTarget
            const nombreestacion = button.getAttribute('data-bs-nombreestacion')
            const idestacion = button.getAttribute('data-bs-idestacion')

            modalinfo.querySelector('h4').textContent = nombreestacion

            // AJAX
            const xhr = new XMLHttpRequest();
            const url = "Controller?op=DameComents&idestacion="+idestacion
            xhr.open("GET", url, true);
            xhr.onload = () => {
                console.log('2')
                  const modalbody = modalinfo.querySelector('.modal-body')
                  modalbody.innerHTML = xhr.responseText;
                
            };
            xhr.send();
        })
    }
}
