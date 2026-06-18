<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }

    body {
        background-image: url('./imagens/arena_background.png'); 
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container-login {
        width: 100%;
        max-width: 500px;
        padding: 20px;
    }

    .cartao-login {
        background-color: rgba(18, 10, 143, 0.85); 
        padding: 40px; /* Espaçamento interno simétrico */
        border-radius: 30px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        color: white;
    }

    h1 {
        text-align: center;
        font-size: 36px;
        margin-bottom: 25px;
        letter-spacing: 2px;
    }

    .campo {
        margin-bottom: 20px;
    }

    .campo label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
    }

    .campo input {
        width: 100%;
        padding: 12px 20px;
        background: transparent;
        border: 1px solid white;
        border-radius: 25px;
        color: white;
        outline: none;
    }

    .campo input::placeholder {
        color: rgba(255, 255, 255, 0.6);
    }

    .container-botoes {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 15px;
        margin-top: 30px;
    }

    .botao-entrar {
        background-color: white;
        color: #120a8f;
        border: none;
        padding: 12px 60px;
        border-radius: 50px;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        transition: transform 0.2s, background-color 0.2s;
        width: 100%;
    }

    .botao-entrar:hover {
        background-color: #e0e0e0;
        transform: scale(1.03);
    }

    .botao-ir-cadastro {
        color: white;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        margin-top: 15px;
        transition: opacity 0.3s;
    }

    .botao-ir-cadastro:hover {
        text-decoration: none;
        opacity: 0.7;
        cursor: pointer;
    }
    
    .mensagem{
        background-color: rgba(120, 30, 30, 0.85); 
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        margin-bottom: 10px;
        color: white;
        display: flex;
        justify-content: space-between;
        border: none;
        padding: 10px 20px;
        border-radius: 50px;
        font-weight: bold;
        font-size: 16px;
        button{
            cursor: pointer;
            background: none;
            border: none;
            outline: none;
            img{
                transform: rotate(90deg);
            }
        }
    }
</style>
<script>
    function fecharDiv(){
        let div = document.getElementById("aviso");
        if (div.style.display === "none"){
            div.style.display = "flex";
        }else{
            div.style.display = "none";
        }
    }
</script>