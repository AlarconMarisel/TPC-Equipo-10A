<%@ Page Title="Carrito de Reserva" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CarritoReserva.aspx.cs" Inherits="APP_Web_Equipo10A.CarritoReserva" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reservation-container {
            min-height: 100vh;
            background-color: var(--background-light);
        }
        
        
        .main-content {
            flex: 1;
            padding: 1rem 1rem;
        }
        
        @media (min-width: 640px) {
            .main-content {
                padding: 1rem 1.5rem;
            }
        }
        
        @media (min-width: 1024px) {
            .main-content {
                padding: 1rem 2rem;
            }
        }
        
        @media (min-width: 640px) {
            .main-content {
                padding: 2.5rem 1.5rem;
            }
        }
        
        @media (min-width: 1024px) {
            .main-content {
                padding: 4rem 2rem;
            }
        }
        
        .content-container {
            max-width: 72rem;
            margin: 0 auto;
        }
        
        .page-title {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .page-title-text {
            color: #1f2937;
            font-size: 2.25rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.033em;
            min-width: 18rem;
        }
        
        .reservation-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
        }
        
        @media (min-width: 1024px) {
            .reservation-grid {
                grid-template-columns: 2fr 1fr;
                gap: 3rem;
            }
        }
        
        .items-section {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .item-card {
            display: flex;
            align-items: center;
            gap: 1rem;
            background-color: white;
            padding: 1rem;
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            justify-content: space-between;
        }
        
        .item-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .item-image {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            aspect-ratio: 1/1;
            border-radius: 0.5rem;
            width: 64px;
            height: 64px;
        }
        
        .item-details {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .item-name {
            color: #1f2937;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.5;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
        }
        
        .item-price {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.5;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .item-actions {
            flex-shrink: 0;
        }
        
        .delete-button {
            color: #6b7280;
            display: flex;
            width: 32px;
            height: 32px;
            align-items: center;
            justify-content: center;
            border-radius: 9999px;
            background: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .delete-button:hover {
            color: #ef4444;
            background-color: #f3f4f6;
        }
        
        .summary-section {
            display: flex;
            flex-direction: column;
        }
        
        .summary-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            position: sticky;
            top: 2.5rem;
        }
        
        .summary-title {
            color: #1f2937;
            font-size: 1.25rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.015em;
            padding-bottom: 1rem;
        }
        
        .summary-details {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            font-size: 0.875rem;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
        }
        
        .summary-label {
            color: #6b7280;
        }
        
        .summary-value {
            color: #1f2937;
            font-weight: 500;
        }
        
        .summary-divider {
            margin: 1rem 0;
            border-top: 1px solid #e2e8f0;
        }
        
        .confirm-button {
            width: 100%;
            display: flex;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 48px;
            background-color: var(--primary-color);
            color: white;
            font-size: 1rem;
            font-weight: 700;
            line-height: 1.5;
            letter-spacing: 0.015em;
            border: none;
            transition: all 0.2s ease;
        }
        
        .confirm-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        .summary-note {
            color: #6b7280;
            font-size: 0.75rem;
            text-align: center;
            margin-top: 1rem;
        }
        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="reservation-container d-flex flex-column min-vh-100">

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-container">
                <!-- Page Title -->
                <div class="page-title">
                    <h1 class="page-title-text">Carrito de Reserva</h1>
                </div>

                <div class="reservation-grid">
                    <!-- Left Column: Items List -->
                    <div class="items-section">
                        <!-- Item 1 -->
                        <div class="item-card">
                            <div class="item-info">
                                <div class="item-image" 
                                     style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAr35BMbKAfp05ZFAPe0RFmOAVCYcRknXlgWsiSzXfB9aA2to9oLzFaNW4Y1-XYi2seb-5gE2oM0Ki0ETxm_gWpfoFJS4rkwBT4-pvVnk8ERS3urAq6osJ1DPep8Cy2Sh1vaS1WlXRVRx-vKEyXpmBC1XUtFA2y2C9SjIo_4GDBPGjZ0F9hO2p9db5csqCuUFsOlDrXTMwp0mDQRRFyKyDh_4Ano3vTIsF9r9hHweukEq8lIeKNW5I_qAnbE9AkO8kE9XYRrJ3Xqbk');">
                                </div>
                                <div class="item-details">
                                    <p class="item-name">Sillón de Cuero Vintage</p>
                                    <p class="item-price">$150.00</p>
                                </div>
                            </div>
                            <div class="item-actions">
                                <button class="delete-button">
                                    <span class="material-symbols-outlined" style="font-size: 20px;">delete</span>
                                </button>
                            </div>
                        </div>

                        <!-- Item 2 -->
                        <div class="item-card">
                            <div class="item-info">
                                <div class="item-image" 
                                     style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCk2nPTUXOEMBecUNWcBWMZK3m5qpLGpjayISeLMe7sJvsYzCWwOf33O4jcCA30_i_i_FA71Y5BcuAJ3-2Sp2yi_7-PuH8_edmdefJ458e1g3kKcaWCT5cP8uH96QDIvOmupV20bw5T0sm7HWO5FDQJVcoMrDjPuqKcdyS6OwboXjDd5s_EO_SDDTNfsDAAHJXUr4CdwlemU6wvJf-i6xQV6Vd1o2iWyiWyVKgSH1xN68eWR0yjCWJq8xku0Hs2UBs8JJlqxfGWASI');">
                                </div>
                                <div class="item-details">
                                    <p class="item-name">Guitarra Acústica Clásica</p>
                                    <p class="item-price">$200.00</p>
                                </div>
                            </div>
                            <div class="item-actions">
                                <button class="delete-button">
                                    <span class="material-symbols-outlined" style="font-size: 20px;">delete</span>
                                </button>
                            </div>
                        </div>

                        <!-- Item 3 -->
                        <div class="item-card">
                            <div class="item-info">
                                <div class="item-image" 
                                     style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCKXNb5jgipZH_rzzUhTWsIpgIqUCLoAAKkBbtZ3n_P6Kyd_rSfA4MfLZ9_orU0smwDOrtoo9MQIuT9vnZo9lmm6YLOP9m078ElUTdYZ--sBk1r2HUjnj1f5l8T1a17fFmEnAQyGtz5tOBIGpapuKzvmp2Ns-4ShV-lbEZiMNIfli0NZeEFcsDEQqiGzOVn9wt7vLR7E_vgmTZeyL8g9FzcelWhnaXmMBN92rnjF-y1H8kwiH0jCOqzNmacAN5r3whwWK0n2LMAqZc');">
                                </div>
                                <div class="item-details">
                                    <p class="item-name">Vajilla de Cerámica (Set de 4)</p>
                                    <p class="item-price">$50.00</p>
                                </div>
                            </div>
                            <div class="item-actions">
                                <button class="delete-button">
                                    <span class="material-symbols-outlined" style="font-size: 20px;">delete</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Payment Summary -->
                    <div class="summary-section">
                        <div class="summary-card">
                            <h2 class="summary-title">Resumen de Pago</h2>
                            <div class="summary-details">
                                <div class="summary-row">
                                    <p class="summary-label">Subtotal</p>
                                    <p class="summary-value">$400.00</p>
                                </div>
                                <div class="summary-row">
                                    <p class="summary-label">Monto de la Seña (10%)</p>
                                    <p class="summary-value">$40.00</p>
                                </div>
                            </div>
                            <hr class="summary-divider" />
                            <a href="PagoSeña.aspx" class="confirm-button text-decoration-none d-block text-center">
                                Confirmar Reserva y Ver Datos de Pago
                            </a>
                            <p class="summary-note">
                                Una vez confirmada, recibirás los datos para completar el pago de la seña.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

