<%@page import="modelo.usuario.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario"); 
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meu Perfil</title>
    
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
    body{
        margin: 0;
        font-family: "Poppins", sans-serif;
    }

    #barraNavegacao {
        background-color: #170b9b;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        height: 6vh;
    }

    .botoes{
        cursor: pointer;
        width: 40px;
        position: relative;
        margin-left: 1%;
        img{
                width: 100%;
                height: auto;
        }
    }

    .pesquisa{
        position: absolute;
        margin-left: 66%;
        margin-bottom: 0.5%;
        width: 25%;
        height: 4%;
        max-width: 30%;
        max-height: 3%;
        align-items: center;
        img{
            max-width: 5%;
            position: absolute; 
            left: 1.5%;
            margin-top: 1%;
        }
        .desativar{
            pointer-events: none;
        }
        input{
            border-radius: 15px;
            padding-left: 7%;
        }
    }

    .menulateral{
       font-size: 115%;
       top: 5.3%;
       left: 0;
       height: 32%;    
       border-radius: 5px;
       padding-top: 5px;
       width: 0;      
       position: absolute;      
       overflow: hidden;     
       transition: 0.3s;      
       background-color: #170b9b;
       z-index: 1000;
       .itens_menu_lateral{
           color: white;
           display: flex;
           flex-direction: column;
           text-decoration: none;
           padding-top: 25px;
           padding-bottom: 25px;
           padding-left: 20px;
           a{
               display: flex;       
               align-items: center;
               text-decoration: none; 
               color: inherit;        
               outline: none;        
               border: none;
           }
       }
   }
    .menulateral.active{
        width: 250px;
    }
    
    .menulateral a:hover{
        font-weight: 700;
        color: #FFFF; 
    }
    
    .deletar{
        width: 70%;
        margin-left: 20px;
        display: grid;
        justify-content: center;
        align-items: center;
        border: 2px solid #FFFF;
        border-radius: 8px;
        border-color: #FFFF;
    }

    .deletar:hover{
        background-color: #FFFF;
        a{
            color: #170b9b;
        }
    }

    .linhavertical{
        border-left: 3.1px solid white; 
        height: 20px;                 
        margin: 0 15px;              
        display: inline-block;        
        vertical-align: middle;
        align-items: center;
        justify-content: center;
    }
    .bemvindo{
        font-size: 120%;
        color: #FFFF;

    }
    
    .container {
        max-width: 1000px;
        margin: 50px auto;
        padding: 0 20px;
    }

    .container h1 {
        font-size: 36px;
        margin-bottom: 5px;
        font-weight: bold;
    }

    .container p {
        color: #666;
        margin-bottom: 30px;
    }

    .card {
        border: 1px solid #ccc;
        border-radius: 15px;
        padding: 40px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        background-color: #fff;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .grade {
        display: grid;
        grid-template-columns: 1fr 1fr;
        width: 100%;
        gap: 40px;
        margin-bottom: 40px;
        position: relative;
    }

    .grade::after {
        content: "";
        position: absolute;
        left: 50%;
        top: 0;
        bottom: 0;
        width: 1px;
        background-color: #ddd;
    }

    .campo {
        margin-bottom: 25px;
    }

    .campo strong {
        display: block;
        font-size: 18px;
        margin-bottom: 5px;
        color: #000;
    }

    .campo span {
        font-size: 16px;
        color: #555;
        word-break: break-all;
    }

    .botao-alterar {
        background-color: #120a8f;
        color: white;
        border: none;
        padding: 15px 60px;
        border-radius: 50px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        transition: transform 0.2s, background-color 0.2s;
    }

    .botao-alterar:hover {
        background-color: #0a065e;
        transform: scale(1.02);
    }
    
    .menulateral{
        font-size: 115%;
        top: 5.3%;
        left: 0;
        height: 210px;    
        border-radius: 5px;
        padding-top: 5px;
        width: 0;      
        position: absolute;      
        overflow: hidden;     
        transition: 0.3s;      
        background-color: #170b9b;
        z-index: 1000;
        .itens_menu_lateral{
            color: white;
            display: flex;
            flex-direction: column;
            text-decoration: none;
            padding-top: 25px;
            padding-bottom: 25px;
            padding-left: 20px;
            a{
                display: flex;       
                align-items: center;
                text-decoration: none; 
                color: inherit;        
                outline: none;        
                border: none;
            }
        }
    }
    .menulateral.active{
        width: 250px;
    }
    
    .menulateral a:hover{
        font-weight: 700;
        color: #FFFF; 
    }
    
    .deletar{
        width: 70%;
        margin-left: 20px;
        display: grid;
        justify-content: center;
        align-items: center;
        border: 2px solid #FFFF;
        border-radius: 8px;
        border-color: #FFFF;
    }

    .deletar:hover{
        background-color: #FFFF;
        a{
            color: #170b9b;
        }
    }

    .linhavertical{
        border-left: 3.1px solid white; 
        height: 20px;                 
        margin: 0 15px;              
        display: inline-block;        
        vertical-align: middle;
        align-items: center;
        justify-content: center;
    }
    
    .campo input {
        border: 1px solid #ccc;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        width: 85%;
        font-size: 1em;
        padding: 12px 20px;
        background: transparent;
        border-radius: 25px;
        outline: none;
    }

    .campo input::placeholder {
        color: #808080;
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