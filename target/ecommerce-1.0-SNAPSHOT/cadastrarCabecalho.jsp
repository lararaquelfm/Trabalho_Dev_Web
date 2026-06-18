<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }

    body {
        background-image: url('imagens/arena_background.png'); 
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container-cadastro {
        width: 100%;
        max-width: 650px;
        padding: 20px 40px;
    }

    .cartao-cadastro {
        background-color: rgba(18, 10, 143, 0.85); 
        padding: 40px;
        border-radius: 30px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        color: white;
        display: flex;
        flex-direction: column;
    }

    h1 {
        text-align: center;
        font-size: 35px;
        margin-bottom: 15px;
        letter-spacing: 2px;
    }

    .campo {
        margin-bottom: 8px;
    }

    .campo label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .campo input {
        width: 100%;
        padding: 10px 20px;
        background: transparent;
        border: 1px solid white;
        border-radius: 25px;
        color: white;
        outline: none;
    }

    .campo input::placeholder {
        color: rgba(255, 255, 255, 0.6);
    }

    .linha {
        display: flex;
        gap: 15px;
    }

    .linha .campo {
        flex: 1;
    }

    .container-botao {
        display: flex;
        justify-content: center;
        margin-top: 25px;
    }

    .botao-cadastrar {
        background-color: white;
        color: #120a8f;
        border: none;
        padding: 10px 50px;
        border-radius: 50px;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        transition: transform 0.2s, background-color 0.2s;
    }

    .botao-cadastrar:hover {
        background-color: #e0e0e0;
        transform: scale(1.05);
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