<%@ Page Title="Panel de Usuario" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="PanelUsuario.aspx.cs" Inherits="APP_Web_Equipo10A.PanelUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reservations-container {
            min-height: 100vh;
            background-color: var(--background-light);
            display: flex;
            flex: 1;
            justify-content: center;
            padding: 1.25rem 0;
        }
        
        .reservations-content {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 80rem;
            flex: 1;
        }
        
        
        .main-content {
            background-color: white;
            border-radius: 0 0 0.75rem 0.75rem;
            flex-grow: 1;
            padding: 1rem;
        }
        
        @media (min-width: 640px) {
            .main-content {
                padding: 1.5rem;
            }
        }
        
        @media (min-width: 1024px) {
            .main-content {
                padding: 2rem;
            }
        }
        
        .page-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            padding: 1rem;
        }
        
        .page-title-section {
            display: flex;
            min-width: 18rem;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .page-title {
            color: #0f172a;
            font-size: 2.25rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.033em;
        }
        
        .page-subtitle {
            color: #64748b;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
        }
        
        .tabs-container {
            padding: 0 1rem 0.75rem;
        }
        
        .tabs {
            display: flex;
            border-bottom: 1px solid #cbd5e1;
            gap: 1rem;
            overflow-x: auto;
        }
        
        @media (min-width: 640px) {
            .tabs {
                gap: 2rem;
            }
        }
        
        .tab {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-bottom: 3px solid transparent;
            color: #64748b;
            padding: 1rem 0 0.8125rem;
            white-space: nowrap;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .tab.active {
            border-bottom-color: var(--primary-color);
            color: #0f172a;
        }
        
        .tab-text {
            font-size: 0.875rem;
            font-weight: 700;
            line-height: 1.5;
            letter-spacing: 0.015em;
        }
        
        .content-section {
            padding: 1rem 1rem 1.5rem;
        }
        
        .section-title {
            color: #0f172a;
            font-size: 1.375rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.015em;
            padding-bottom: 0.75rem;
        }
        
        .section-description {
            color: #1e293b;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            padding-bottom: 0.75rem;
            padding-top: 0.25rem;
        }
        
        .reservations-list {
            margin-top: 1rem;
        }
        
        .reservation-card {
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            background-color: var(--background-light);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .reservation-header {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        @media (min-width: 768px) {
            .reservation-header {
                flex-direction: row;
            }
        }
        
        .reservation-info h3 {
            color: #0f172a;
            font-size: 1.25rem;
            font-weight: 700;
        }
        
        .reservation-date {
            color: #64748b;
            font-size: 0.875rem;
        }
        
        .countdown {
            text-align: center;
            padding: 0.75rem;
            border-radius: 0.5rem;
            width: 100%;
        }
        
        @media (min-width: 768px) {
            .countdown {
                width: auto;
            }
        }
        
        .countdown.amber {
            background-color: #fef3c7;
            color: #92400e;
        }
        
        .countdown.red {
            background-color: #fee2e2;
            color: #dc2626;
        }
        
        .countdown-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .countdown-time {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.025em;
        }
        
        .contact-section {
            border-top: 1px solid #e2e8f0;
            padding-top: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .contact-title {
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        
        .contact-info {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem 2rem;
            font-size: 0.875rem;
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .contact-icon {
            color: #64748b;
            font-size: 1.25rem;
        }
        
        .contact-text {
            color: #374151;
        }
        
        .items-section {
            margin-bottom: 0;
        }
        
        .items-title {
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .items-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .item-card {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem;
            border-radius: 0.5rem;
            background-color: white;
            border: 1px solid #e2e8f0;
        }
        
        @media (min-width: 640px) {
            .item-card {
                flex-direction: row;
                align-items: center;
            }
        }
        
        .item-image {
            width: 6rem;
            height: 6rem;
            object-fit: cover;
            border-radius: 0.375rem;
            flex-shrink: 0;
        }
        
        .item-details {
            flex-grow: 1;
        }
        
        .item-name {
            font-weight: 600;
            color: #1e293b;
        }
        
        .item-original-price {
            font-size: 0.875rem;
            color: #64748b;
        }
        
        .item-payment {
            width: 100%;
            text-align: left;
        }
        
        @media (min-width: 640px) {
            .item-payment {
                width: auto;
                text-align: right;
            }
        }
        
        .payment-details {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .deposit-paid {
            font-size: 0.875rem;
            color: #64748b;
        }
        
        .deposit-amount {
            font-weight: 500;
            color: #374151;
        }
        
        .remaining-amount {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
        }
        
        
        @media (max-width: 576px) {
            .reservations-container {
                padding: 0.5rem 0;
            }
            
            .main-content {
                padding: 0.75rem;
            }
            
            .page-header {
                padding: 0.75rem;
            }
            
            .page-title {
                font-size: 1.875rem;
            }
            
            .tabs-container {
                padding: 0 0.75rem 0.5rem;
            }
            
            .content-section {
                padding: 0.75rem 0.75rem 1rem;
            }
            
            .reservation-card {
                padding: 1rem;
            }
            
            .contact-info {
                gap: 1rem 1.5rem;
            }
            
            .item-card {
                padding: 0.75rem;
            }
            
            .item-image {
                width: 5rem;
                height: 5rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="reservations-container">
        <div class="reservations-content">
            <!-- Main Content -->
            <main class="main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-title-section">
                        <p class="page-title">Panel de Usuario</p>
                        <p class="page-subtitle">Gestiona tus reservas y compras en un solo lugar.</p>
                    </div>
                </div>
                
                <!-- Tabs -->
                <div class="tabs-container">
                    <div class="tabs">
                        <a class="tab" href="#">
                            <p class="tab-text">Pendientes de Pago Seña</p>
                        </a>
                        <a class="tab active" href="#">
                            <p class="tab-text">Reservas Activas</p>
                        </a>
                        <a class="tab" href="#">
                            <p class="tab-text">Compras Completadas</p>
                        </a>
                        <a class="tab" href="#">
                            <p class="tab-text">Vencidas/Rechazadas</p>
                        </a>
                    </div>
                </div>
                
                <!-- Content Section -->
                <div class="content-section">
                    <h2 class="section-title">Reservas Activas</h2>
                    <p class="section-description">
                        Contacta al administrador para coordinar la inspección y el pago final. Esta pantalla es solo informativa.
                    </p>
                    
                    <!-- Reservations List -->
                    <div class="reservations-list">
                        <!-- Reservation 1 -->
                        <div class="reservation-card">
                            <div class="reservation-header">
                                <div class="reservation-info">
                                    <h3>Reserva #84391</h3>
                                    <p class="reservation-date">Generada el 15 de Octubre, 2023</p>
                                </div>
                                <div class="countdown amber">
                                    <p class="countdown-label">Vence en:</p>
                                    <p class="countdown-time">48:30:15</p>
                                </div>
                            </div>
                            
                            <div class="contact-section">
                                <h4 class="contact-title">Datos de Contacto del Administrador</h4>
                                <div class="contact-info">
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">person</span>
                                        <span class="contact-text">Juan Pérez</span>
                                    </div>
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">call</span>
                                        <span class="contact-text">+54 9 11 1234-5678</span>
                                    </div>
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">mail</span>
                                        <span class="contact-text">contacto@usedgoods.com</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="items-section">
                                <h4 class="items-title">Artículos en esta Reserva</h4>
                                <div class="items-list">
                                    <!-- Item 1 -->
                                    <div class="item-card">
                                        <img class="item-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD6GewYf0VA0yXn1xWEwa4GNfpW6TLLCQsWTf5Asi6WcEXbK3PAdAGrP3SQe9qvQAZjFLmYNG9MJvRHPuWZ46_atlVqQibJ1nfNs8yclYHvFoXakHM2z8vG-x6YjWalH8AHoQaJtNFRcJR821yKHFUlNuKjk1idAFGLzBXcPdHGTHCqTL4TytCaGKCYna8D9gsnWorhpu3dblJ7EHvQO2du-8lfogmz35dueUCAOHHDycSsu2N0cJK2zMxSVD5vTHDrqDny0e5Ka0E" alt="A classic silver wristwatch on a dark background" />
                                        <div class="item-details">
                                            <p class="item-name">Reloj de Pulsera Clásico</p>
                                            <p class="item-original-price">Precio Original: $200.00</p>
                                        </div>
                                        <div class="item-payment">
                                            <div class="payment-details">
                                                <p class="deposit-paid">Seña Pagada: <span class="deposit-amount">$20.00</span></p>
                                                <p class="remaining-amount">Restante: $180.00</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Item 2 -->
                                    <div class="item-card">
                                        <img class="item-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBQnWvUyEjhR0Cz-ZEbyA_SQmKegguR6AZ78ZHPvlgrZHuX2f-9k6qOQp4l2icYrzvWfVkWnMDuc-b-EtFxY7T7CRFWmK0G6ZMfJOeBRrUGglkrUw6NVo0RzLyatMP1ATvI5MpyfKLuX86XstrEmU8F6Qgs61I0MWrTSXIu5qPSOk5Cz3ojfrfvPNzPRhOOyuovUH-iQsYvmsDglQchnr4_4IeqHePLCd0Xkdtq5JAnZrsbrdNLBICXwq2wdDm0Tw52A5eZ6275al4" alt="Vintage leather-bound books on a shelf" />
                                        <div class="item-details">
                                            <p class="item-name">Colección de Libros Antiguos</p>
                                            <p class="item-original-price">Precio Original: $150.00</p>
                                        </div>
                                        <div class="item-payment">
                                            <div class="payment-details">
                                                <p class="deposit-paid">Seña Pagada: <span class="deposit-amount">$15.00</span></p>
                                                <p class="remaining-amount">Restante: $135.00</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Reservation 2 -->
                        <div class="reservation-card">
                            <div class="reservation-header">
                                <div class="reservation-info">
                                    <h3>Reserva #84215</h3>
                                    <p class="reservation-date">Generada el 14 de Octubre, 2023</p>
                                </div>
                                <div class="countdown red">
                                    <p class="countdown-label">Vence en:</p>
                                    <p class="countdown-time">05:15:42</p>
                                </div>
                            </div>
                            
                            <div class="contact-section">
                                <h4 class="contact-title">Datos de Contacto del Administrador</h4>
                                <div class="contact-info">
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">person</span>
                                        <span class="contact-text">Juan Pérez</span>
                                    </div>
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">call</span>
                                        <span class="contact-text">+54 9 11 1234-5678</span>
                                    </div>
                                    <div class="contact-item">
                                        <span class="material-symbols-outlined contact-icon">mail</span>
                                        <span class="contact-text">contacto@usedgoods.com</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="items-section">
                                <h4 class="items-title">Artículos en esta Reserva</h4>
                                <div class="items-list">
                                    <!-- Item 1 -->
                                    <div class="item-card">
                                        <img class="item-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDQVxIFIWYBjgjfzy7WYNfV_KfQ6nrwUBB2zSuReDjv0BBLUMUpA74qGQKhkOfmqNrD8-FEofB8DW28c5km8L3u9TXGaAnthGnsRblvgYYGQf215kkvxChjshq3BFC7fiUH43DoYdY5shcG-4lenphSpGX1Y0SjtIHn_Z5UYID07VYXGMjgi84I_4u4FIhZwcNTrXGdH3SlrdC4GqeyMAdQ4ki8Zj_AngnkgrpHNHTSZxUodOYsj2QOGoT7pkmZ1QUlxpw00ZI5qkM" alt="A vintage film camera with a leather strap" />
                                        <div class="item-details">
                                            <p class="item-name">Cámara Fotográfica Vintage</p>
                                            <p class="item-original-price">Precio Original: $350.00</p>
                                        </div>
                                        <div class="item-payment">
                                            <div class="payment-details">
                                                <p class="deposit-paid">Seña Pagada: <span class="deposit-amount">$35.00</span></p>
                                                <p class="remaining-amount">Restante: $315.00</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>


