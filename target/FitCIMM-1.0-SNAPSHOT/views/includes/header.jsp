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
            --fit-rojo: #DC3545;
            --fit-negro: #121212;
            --fit-gris-oscuro: #212529;
        }
        
        .navbar-sena {
            background: linear-gradient(135deg, var(--fit-negro) 0%, var(--fit-gris-oscuro) 100%);
            border-bottom: 3px solid var(--fit-rojo);
        }
        
        .btn-sena {
            background-color: var(--fit-rojo);
            border-color: var(--fit-rojo);
            color: white;
        }
        
        .btn-sena:hover {
            background-color: #bb2d3b;
            border-color: #b02a37;
            color: white;
        }
        
        .card-header-sena {
            background: linear-gradient(135deg, var(--fit-negro) 0%, var(--fit-gris-oscuro) 100%);
            color: white;
            border-bottom: 2px solid var(--fit-rojo);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(220, 53, 69, 0.08);
        }
        
        .badge-activo {
            background-color: var(--fit-rojo);
        }
        
        .badge-inactivo {
            background-color: #6c757d;
        }
        
        .footer-sena {
            background-color: var(--fit-negro);
            color: white;
            border-top: 3px solid var(--fit-rojo);
            margin-top: 50px;
        }
    </style>
</head>
<body>