<%@ Page Title="Pago de Seña" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="PagoSeña.aspx.cs" Inherits="APP_Web_Equipo10A.PagoSeña" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reservation-pending-container {
            min-height: 100vh;
            background-color: var(--background-light);
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: center;
            padding: 2.5rem 1rem;
        }

        .reservation-content {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 32rem;
            flex: 1;
        }

        .reservation-card {
            background-color: white;
            border-radius: 0.75rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            border: 1px solid #e5e7eb;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        @media (min-width: 768px) {
            .reservation-card {
                padding: 2rem;
            }
        }

        .status-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 4rem;
            height: 4rem;
            background-color: rgba(17, 115, 212, 0.1);
            border-radius: 9999px;
            margin-bottom: 1.5rem;
        }

        .status-icon-symbol {
            color: var(--primary-color);
            font-size: 2.25rem;
        }

        .reservation-title {
            color: #0d141b;
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.025em;
            padding: 0 1rem;
            text-align: center;
            padding-bottom: 0.75rem;
        }

        @media (min-width: 768px) {
            .reservation-title {
                font-size: 1.875rem;
            }
        }

        .reservation-description {
            color: #4c739a;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            padding-bottom: 1.5rem;
            padding-top: 0.25rem;
            padding-left: 1rem;
            padding-right: 1rem;
            text-align: center;
        }

        .payment-info {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .payment-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            background-color: var(--background-light);
            border: 1px solid #e5e7eb;
            padding: 0 1rem;
            min-height: 3.5rem;
            justify-content: space-between;
            border-radius: 0.5rem;
        }

        .payment-item-content {
            display: flex;
            align-items: center;
            gap: 1rem;
            overflow: hidden;
        }

        .payment-icon {
            color: #0d141b;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.5rem;
            background-color: #e7edf3;
            flex-shrink: 0;
            width: 2.5rem;
            height: 2.5rem;
        }

        .payment-text {
            color: #0d141b;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            flex: 1;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .copy-button {
            display: flex;
            min-width: 84px;
            max-width: 480px;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 2rem;
            padding: 0 1rem;
            background-color: #e7edf3;
            color: #0d141b;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
            width: fit-content;
            border: none;
            transition: all 0.2s ease;
        }

            .copy-button:hover {
                background-color: #d1d5db;
            }

        .info-section {
            width: 100%;
        }

        .info-card {
            display: flex;
            flex: 1;
            flex-direction: column;
            align-items: flex-start;
            justify-content: space-between;
            gap: 1rem;
            border-radius: 0.5rem;
            background-color: rgba(17, 115, 212, 0.1);
            padding: 1.25rem;
            text-align: left;
        }

        .info-content {
            display: flex;
            width: 100%;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .info-icon {
            color: var(--primary-color);
            margin-top: 0.25rem;
        }

        .info-icon-symbol {
            font-size: 1.25rem;
        }

        .info-text {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .info-title {
            color: #0d141b;
            font-size: 1rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .info-description {
            color: #4c739a;
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.5;
        }

        .action-button {
            width: 100%;
            margin-top: 2rem;
        }

        .back-button {
            display: flex;
            min-width: 84px;
            width: 100%;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 2.75rem;
            padding: 0 1rem;
            background-color: var(--primary-color);
            color: white;
            font-size: 1rem;
            font-weight: 700;
            line-height: 1.5;
            border: none;
            transition: all 0.2s ease;
        }

            .back-button:hover {
                background-color: rgba(17, 115, 212, 0.9);
            }

        .amount-highlight {
            font-weight: 700;
            color: #0d141b;
        }


        @media (max-width: 576px) {
            .reservation-pending-container {
                padding: 1rem 0.5rem;
            }

            .reservation-card {
                padding: 1rem;
            }

            .reservation-title {
                font-size: 1.25rem;
                padding: 0 0.5rem;
            }

            .reservation-description {
                padding-left: 0.5rem;
                padding-right: 0.5rem;
            }

            .payment-item {
                padding: 0 0.75rem;
                min-height: 3rem;
            }

            .payment-icon {
                width: 2rem;
                height: 2rem;
            }

            .payment-text {
                font-size: 0.875rem;
            }

            .copy-button {
                height: 1.75rem;
                padding: 0 0.75rem;
                font-size: 0.75rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="reservation-pending-container">
        <div class="reservation-content">
            <div class="reservation-card">
                <!-- Status Icon -->
                <div class="status-icon">
                    <span class="material-symbols-outlined status-icon-symbol">hourglass_top</span>
                </div>

                <!-- Title -->
                <h1 class="reservation-title">Tu reserva está pendiente de aprobación</h1>

                <!-- Description -->
                <p class="reservation-description">
                    Para activar tu reserva por 72 horas, por favor transfiere el monto de la seña de 
                    <span class="amount-highlight">
                        <asp:Label ID="lblMontoSeña" runat="server" Text="$0.00"></asp:Label>
                    </span>

                </p>

                <!-- Payment Information -->
                <div class="payment-info">
                    <!-- CBU -->
                    <div class="payment-item">
                        <div class="payment-item-content">
                            <div class="payment-icon">
                                <span class="material-symbols-outlined">account_balance</span>
                            </div>
                            <p class="payment-text">CBU: 1234567890123456789012</p>
                        </div>
                        <div class="shrink-0">
                            <button class="copy-button">
                                <span>Copiar</span>
                            </button>
                        </div>
                    </div>

                    <!-- Alias -->
                    <div class="payment-item">
                        <div class="payment-item-content">
                            <div class="payment-icon">
                                <span class="material-symbols-outlined">badge</span>
                            </div>
                            <p class="payment-text">Alias: RESERVA.WEB.APP</p>
                        </div>
                        <div class="shrink-0">
                            <button class="copy-button">
                                <span>Copiar</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Information Section -->
                <div class="info-section">
                    <div class="info-card">
                        <div class="info-content">
                            <div class="info-icon">
                                <span class="material-symbols-outlined info-icon-symbol">info</span>
                            </div>
                            <div class="info-text">
                                <p class="info-title">Aviso de confirmación</p>
                                <p class="info-description">
                                    Recibirás un email de confirmación en cuanto el administrador valide la recepción del pago. 
                                    (Esto puede demorar unas horas).
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upload Comprobante -->
                <div class="upload-section mt-4">
                    <label class="form-label fw-semibold">Adjuntar comprobante de seña</label>
                    <asp:FileUpload ID="fileComprobante" runat="server" CssClass="form-control" />
                </div>

                <!-- Confirmar Seña -->
                <div class="confirm-section mt-3">
                    <asp:Button ID="btnConfirmarPago" runat="server"
                        Text="Confirmar Seña"
                        CssClass="btn btn-primary"
                        OnClick="btnConfirmarPago_Click" />
                </div>

                <!-- Action Button -->
                <div class="action-button">
                    <a href="Default.aspx" class="back-button text-decoration-none d-block text-center">
                        <span>Volver al inicio</span>
                    </a>
                </div>


            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>

