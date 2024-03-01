const { createApp } = Vue;


const vueinst = createApp({
    data() {
        return {
            posts: []
        };
    },
}).mount(".container-main-content");

const login_button = createApp({
    data() {
        return {
            buttonText: ''
        };
    },
    mounted() {
        //check if there is a current session
        let req = new XMLHttpRequest();
        req.onreadystatechange = function(){
            if(req.readyState === 4 && req.status === 200){
                //there is a session
                login_button.buttonText = 'Logout';
            } else if(req.readyState === 4 && req.status === 500) {
                login_button.buttonText = 'Login';
            }
        };
        req.open('GET', '/checksession');
        req.send();
    },
    methods: {
        loginButtonHandler() {
            if(login_button.buttonText === 'Logout') {
                let req = new XMLHttpRequest();
                req.onreadystatechange = function(){
                    if(req.readyState === 4 && req.status === 200){
                        alert('Logged out');
                        window.location.reload();
                    }
                };
                req.open('POST', '/logout');
                req.send();
            }
            if(login_button.buttonText === 'Login') {
                window.location.href='login.html';
            }
        }
    }
}).mount(".login-button");

function getPosts(){
    let req = new XMLHttpRequest();

    req.onreadystatechange = function(){
        if(req.readyState === 4 && req.status === 200){
            let posts = JSON.parse(req.responseText);
            vueinst.posts = posts;
        }
    };

    req.open('GET','/getposts');
    req.send();
}

function signUp(){
    if(document.getElementById('signup-pass').value !== document.getElementById('signup-confirm').value){
        alert("Passwords don't match");
        return;
    }
    let loginData = {
        first_name: document.getElementById('signup-firstname').value,
        last_name: document.getElementById('signup-lastname').value,
        email: document.getElementById('signup-email').value,
        password: document.getElementById('signup-pass').value
    };
    let req = new XMLHttpRequest();
    req.onreadystatechange = function(){
        if(req.readyState == 4 && req.status == 200){
            alert('Signed Up successfully');
        } else if(req.readyState == 4 && req.status !== 200){
            alert('Signed Up FAILED');
        }
    };
    req.open('POST','/signup');
    req.setRequestHeader('Content-Type', 'application/json');
    req.send(JSON.stringify(loginData));
}

function login(){
    let loginData = { email: document.getElementById("login-email").value,
                    password: document.getElementById("login-pass").value};
    let req = new XMLHttpRequest();
    req.onreadystatechange = function(){
        if(req.readyState == 4 && req.status == 200){
            alert('Logged In successfully');
            window.location.href = 'home.html';
        } else if(req.readyState == 4 && req.status !== 200){
            alert('Login FAILED');
        }
    };
    req.open('POST','/login');
    req.setRequestHeader('Content-Type','application/json');
    req.send(JSON.stringify(loginData));
}

