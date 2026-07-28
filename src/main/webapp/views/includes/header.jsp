<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("titulo") != null ? request.getAttribute("titulo") : "Sistema FitCIMM" %></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --sena-naranja: #FF5800;
            --sena-verde: #39A900;
            --sena-azul: #004884;
        }
        
        .navbar-sena {
            background: linear-gradient(135deg, var(--sena-verde) 0%, var(--sena-azul) 100%);
        }
        
        .btn-sena {
            background-color: var(--sena-naranja);
            border-color: var(--sena-naranja);
            color: white;
        }
        
        .btn-sena:hover {
            background-color: #e04d00;
            border-color: #e04d00;
            color: white;
        }
        
        .card-header-sena {
            background: linear-gradient(135deg, var(--sena-verde) 0%, var(--sena-azul) 100%);
            color: white;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(57, 169, 0, 0.1);
        }
        
        .badge-activo {
            background-color: var(--sena-verde);
        }
        
        .badge-inactivo {
            background-color: #6c757d;
        }
        
        .footer-sena {
            background-color: var(--sena-azul);
            color: white;
            margin-top: 50px;
        }
    </style>
</head>
<body>
