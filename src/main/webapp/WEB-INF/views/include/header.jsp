<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Home</title>
  <link rel="icon" href="/shop/resources/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="/shop/resources/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="/shop/resources/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="/shop/resources/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="/shop/resources/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="/shop/resources/vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="/shop/resources/vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="/shop/resources/css/style.css">
</head>
<body>
   <!--================ Start Header Menu Area =================-->
   <header class="header_area">
      <div class="main_menu">
         <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container">
               <a class="navbar-brand logo_h" href="/shop/home"><img src="/shop/resources/img/logo.png" alt=""></a>
               <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                  aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
               </button>
               <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                  <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                     <li class="nav-item"><a class="nav-link" href="/shop/home">Home</a></li>
                     <li class="nav-item active submenu dropdown">
                     <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Shop</a>
                        <ul class="dropdown-menu">
                           <li class="nav-item"><a class="nav-link" href="/shop/category">Shop Category</a></li>
                           <li class="nav-item"><a class="nav-link" href="/shop/confirmation">Confirmation</a></li>
                           <li class="nav-item"><a class="nav-link" href="/shop/cart">Shopping Cart</a></li>
                        </ul>
                     </li>
                     <li class="nav-item submenu dropdown">
                     <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">QnA</a>
                        <ul class="dropdown-menu">
                           <li class="nav-item"><a class="nav-link" href="/shop/qa-list">QnA</a></li>
                        </ul>
                     </li>
                     <li class="nav-item"><a class="nav-link" href="/shop/manager/write-product">Manager</a></li>
                  </ul>
                  <ul class="nav-shop ml-auto mr-auto">
                         <li class="nav-item"><button><i class="ti-search"></i></button></li>
                         <li class="nav-item"><button onclick="location.href='/shop/cart'"><i class="ti-shopping-cart"></i><span class="nav-shop__circle">3</span></button> </li>
                     <c:choose>
                        <c:when test="${ empty loginuser }">
                        <li class="nav-item">
                        <a class="button button-header" href="/shop/account/login">Login</a>
                        <a class="button button-header" href="/shop/account/register">Register</a>
                        </li>
                     </c:when>
                     <c:otherwise>
                  <li class="nav-item">
                     <a class="nav-link" href="/shop/account/mypage" style="text-decoration: none">${ loginuser.memberId }님 환영합니다.</a>
                  </li>
                  <li class="nav-item">
                     <a class="button button-header" href="/shop/account/logout">Logout</a>
                  </li>
               </c:otherwise>
                     </c:choose>
                  </ul>
               </div>
            </div>
         </nav>
      </div>
   </header>
   <!--================ End Header Menu Area =================-->
