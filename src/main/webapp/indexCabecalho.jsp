<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
    body{
        margin: 0;
        font-family: "Poppins", sans-serif;
    }
    
    .botoes{
        position: relative;
        margin-left: 5px;
        display: flex;
        align-items: center;
        height: 100%;
        width: auto;
        
    }
    
    .seta{
        transform: rotate(180deg);
    }
    
    .profile{
        width: 40px;
        height: auto;
    }
    
    .imagem_texto_login{
        display: inline-flex;
        align-items: center;
        text-decoration: none;
        font-weight: bold;
        color: white;
        span{
            white-space: nowrap;
        }
    }
    
    #barraNavegacao {
        background-color: #170b9b;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        height: 6vh;
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

    .linhavertical{
        border-left: 3.1px solid white; 
        height: 20px;                 
        margin: 0 15px;              
        display: inline-block;        
        vertical-align: middle;
        align-items: center;
        justify-content: center;
    }
    .login{
        p{
            margin: 0;
        }
        text-align: center;
        border: 1px solid #ccc;
        border-radius: 25px;
        outline: none;
        width: 300px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        cursor: pointer;
        margin-left: 5px;
        font-size: 1.5em;
        font-weight: bold;
        color: #FFFF;
        text-decoration: none;
        transition: 0.3s;

    }
    
    login:hover{
       text-decoration: underline; 
    }
    #background{
        width: 100%;
    }

    #camisas{
        display: flex;
        gap: 1vw;
        position: relative;
        bottom: 15vh;
        padding: 1vw;
    }

    .camisa{
        cursor: pointer;
        background-color: white;
        width: calc(18% + 8px); 
        color: black;
        border: 0.1em solid black;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        border-radius: 15px;
        padding: 0.1%;
        p, h1{
            text-align: center;
        }
        p{
            font-size: 1.5em;
        }
        h1{
            font-size: 2em;
            margin-top: -7%;
        }
        button, img{
            margin: 0 auto;
            display: block;
        }
        button{
            border-color: blue;
            border-radius: 10px;
            background-color: blue;
            color: white;
            width: 80%;
            height: 5vh;
            margin-top: -5%;
            margin-bottom: 7%;
            font-size: 1em;
            cursor: pointer;
            img{
                margin-left: 5%;
                top: 0.15em;
                width: 1em;
                position: relative;
                display: inline;
            }
        }
    }
    #ofertas{
        margin-top: 0;
        margin-bottom: 0;
        font-size: 3em;
        margin-left: 1vw;
    }
    .deslizar{
        position: relative;
        width: 100%;
        .e_d{
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            img{
                padding-top: 5px;
                width: 23px;
            }
        }
        .esquerda{
            margin-left: 10px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }
        .direita{
            margin-right: 10px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }
    }
    .deslizar .seta {
        border-radius: 50%;
        background: rgba(224, 214, 214, 0.5);
        cursor: pointer;
        align-items: center;
        justify-content: center;
    }
    
    #carrossel{
        display: flex;
        gap: 30px;
        margin: auto; 
        overflow: hidden;
        justify-content: center;
        .camisa{
            padding: 15px;
            width:calc((0.8)*(18% + 8px)) ;
            min-width: 100px;
            height: 350px;
            flex-shrink: 0;
            button{
                font-size: 85%;
            }
        }  
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
    
</style>