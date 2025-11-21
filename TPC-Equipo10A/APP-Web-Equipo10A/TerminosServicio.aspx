<%@ Page Title="Términos de Servicio" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TerminosServicio.aspx.cs" Inherits="APP_Web_Equipo10A.TerminosServicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }
        .terms-content {
            padding: 3rem 0;
        }
        .terms-section {
            margin-bottom: 3rem;
        }
        .terms-section h3 {
            color: #667eea;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .terms-list {
            list-style: none;
            padding-left: 0;
        }
        .terms-list li {
            padding: 0.75rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .terms-list li:before {
            content: "•";
            color: #667eea;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-right: 0.5rem;
        }
        .highlight-box {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 1.5rem 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-5 fw-bold mb-3">Términos de Servicio</h1>
                    <p class="lead mb-0">Última actualización: <asp:Label ID="lblFecha" runat="server" Text="Diciembre 2024"></asp:Label></p>
                </div>
            </div>
        </div>
    </section>

    <section class="terms-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4 p-md-5">
                            
                            <div class="terms-section">
                                <p class="text-muted lead">
                                    Bienvenido a SecondHand. Al acceder y utilizar nuestra plataforma, aceptas cumplir con los siguientes términos y condiciones. 
                                    Por favor, lee cuidadosamente estos términos antes de utilizar nuestros servicios.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>1. Aceptación de los Términos</h3>
                                <p class="text-muted">
                                    Al acceder y utilizar SecondHand, aceptas estar legalmente vinculado por estos Términos de Servicio. 
                                    Si no estás de acuerdo con alguna parte de estos términos, no debes utilizar nuestra plataforma.
                                </p>
                                <p class="text-muted">
                                    Nos reservamos el derecho de modificar estos términos en cualquier momento. Las modificaciones entrarán en vigor 
                                    inmediatamente después de su publicación en la plataforma. Es tu responsabilidad revisar periódicamente estos términos.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>2. Descripción del Servicio</h3>
                                <p class="text-muted">
                                    SecondHand es una plataforma de comercio electrónico que facilita la compra y venta de productos de segunda mano. 
                                    Nuestros servicios incluyen:
                                </p>
                                <ul class="terms-list text-muted">
                                    <li>Catálogo de productos de segunda mano disponibles para compra</li>
                                    <li>Sistema de reservas con pago de seña</li>
                                    <li>Gestión de transacciones entre compradores y vendedores</li>
                                    <li>Panel de administración para gestión de productos y usuarios</li>
                                </ul>
                                <p class="text-muted">
                                    SecondHand actúa únicamente como intermediario entre compradores y vendedores, facilitando las transacciones 
                                    pero no siendo parte directa de la venta.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>3. Registro y Cuentas de Usuario</h3>
                                <p class="text-muted">
                                    Para utilizar ciertos servicios de SecondHand, debes crear una cuenta proporcionando información precisa y completa. 
                                    Eres responsable de:
                                </p>
                                <ul class="terms-list text-muted">
                                    <li>Mantener la confidencialidad de tu contraseña</li>
                                    <li>Todas las actividades que ocurran bajo tu cuenta</li>
                                    <li>Notificarnos inmediatamente de cualquier uso no autorizado de tu cuenta</li>
                                    <li>Proporcionar información veraz y actualizada</li>
                                </ul>
                                <div class="highlight-box">
                                    <strong>Nota importante:</strong> SecondHand se reserva el derecho de suspender o cancelar cuentas que violen estos términos 
                                    o que se utilicen de manera fraudulenta o inapropiada.
                                </div>
                            </div>

                            <div class="terms-section">
                                <h3>4. Proceso de Compra y Reserva</h3>
                                <h5 class="fw-bold mt-4 mb-3">4.1. Sistema de Reservas</h5>
                                <p class="text-muted">
                                    Al agregar productos a tu carrito y confirmar una reserva, aceptas pagar una seña equivalente al 10% del valor total 
                                    de los productos seleccionados. Esta seña garantiza la reserva del producto por un período de 72 horas.
                                </p>
                                
                                <h5 class="fw-bold mt-4 mb-3">4.2. Tiempo de Reserva</h5>
                                <p class="text-muted">
                                    Las reservas tienen una validez de 72 horas desde el momento de la confirmación. Durante este período, 
                                    el producto quedará marcado como "Reservado" y no estará disponible para otros compradores.
                                </p>

                                <h5 class="fw-bold mt-4 mb-3">4.3. Pago Completo</h5>
                                <p class="text-muted">
                                    El comprador debe completar el pago del saldo restante (90%) dentro del período de 72 horas. Si el pago completo 
                                    no se realiza dentro de este plazo, la reserva puede ser cancelada y la seña no será reembolsable.
                                </p>

                                <h5 class="fw-bold mt-4 mb-3">4.4. Cancelación de Reservas</h5>
                                <p class="text-muted">
                                    No se puede cancelar una reserva. La seña no es reembolsable bajo ninguna circunstancia.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>5. Productos y Publicaciones</h3>
                                <h5 class="fw-bold mt-4 mb-3">5.1. Descripción de Productos</h5>
                                <p class="text-muted">
                                    Los vendedores son responsables de proporcionar descripciones precisas y completas de los productos, incluyendo 
                                    su estado, características y cualquier defecto o limitación conocida.
                                </p>

                                <h5 class="fw-bold mt-4 mb-3">5.2. Estado de los Productos</h5>
                                <p class="text-muted">
                                    Los productos se venden "tal cual" según su estado descrito. SecondHand no garantiza el estado, calidad o 
                                    funcionamiento de los productos de segunda mano. Los compradores deben revisar cuidadosamente las descripciones 
                                    y fotografías antes de realizar una compra.
                                </p>

                                <h5 class="fw-bold mt-4 mb-3">5.3. Productos Prohibidos</h5>
                                <p class="text-muted">Está prohibido publicar productos que:</p>
                                <ul class="terms-list text-muted">
                                    <li>Sean ilegales o violen leyes locales o nacionales</li>
                                    <li>Infrinjan derechos de propiedad intelectual</li>
                                    <li>Sean peligrosos o representen un riesgo para la salud</li>
                                    <li>Sean fraudulentos o engañosos</li>
                                    <li>Contengan información falsa o engañosa</li>
                                </ul>
                            </div>

                            <div class="terms-section">
                                <h3>6. Precios y Pagos</h3>
                                <p class="text-muted">
                                    Todos los precios están expresados en la moneda local y son establecidos por los vendedores. SecondHand se reserva 
                                    el derecho de corregir errores de precios, incluso después de que se haya realizado una reserva.
                                </p>
                                <p class="text-muted">
                                    Los pagos se procesan a través de los métodos de pago disponibles en la plataforma. El comprador es responsable 
                                    de proporcionar información de pago válida y autorizar las transacciones.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>7. Responsabilidades y Limitaciones</h3>
                                <h5 class="fw-bold mt-4 mb-3">7.1. Limitación de Responsabilidad</h5>
                                <p class="text-muted">
                                    SecondHand actúa únicamente como intermediario y no se hace responsable por:
                                </p>
                                <ul class="terms-list text-muted">
                                    <li>La calidad, seguridad o legalidad de los productos vendidos</li>
                                    <li>La veracidad de las descripciones proporcionadas por los vendedores</li>
                                    <li>Disputas entre compradores y vendedores</li>
                                    <li>Daños o pérdidas resultantes del uso de productos comprados</li>
                                    <li>Problemas de entrega o logística</li>
                                </ul>

                                <h5 class="fw-bold mt-4 mb-3">7.2. Responsabilidad del Usuario</h5>
                                <p class="text-muted">
                                    Los usuarios son responsables de sus propias acciones en la plataforma, incluyendo la información que proporcionan, 
                                    los productos que publican o compran, y el cumplimiento de todas las leyes aplicables.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>8. Propiedad Intelectual</h3>
                                <p class="text-muted">
                                    Todo el contenido de SecondHand, incluyendo pero no limitado a textos, gráficos, logos, iconos, imágenes, 
                                    clips de audio y software, es propiedad de SecondHand o sus proveedores de contenido y está protegido por 
                                    leyes de propiedad intelectual.
                                </p>
                                <p class="text-muted">
                                    Los usuarios otorgan a SecondHand una licencia no exclusiva para usar, reproducir y mostrar cualquier contenido 
                                    que publiquen en la plataforma, únicamente para los fines de operar y promover SecondHand.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>9. Privacidad</h3>
                                <p class="text-muted">
                                    El uso de SecondHand también está regido por nuestra Política de Privacidad. Al utilizar nuestros servicios, 
                                    aceptas la recopilación y uso de información según se describe en nuestra Política de Privacidad.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>10. Modificaciones del Servicio</h3>
                                <p class="text-muted">
                                    SecondHand se reserva el derecho de modificar, suspender o discontinuar cualquier aspecto del servicio en 
                                    cualquier momento, con o sin previo aviso. No seremos responsables ante ti ni ante ningún tercero por cualquier 
                                    modificación, suspensión o discontinuación del servicio.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>11. Terminación</h3>
                                <p class="text-muted">
                                    Podemos terminar o suspender tu acceso a SecondHand inmediatamente, sin previo aviso, por cualquier motivo, 
                                    incluyendo si violas estos Términos de Servicio. Tras la terminación, tu derecho a utilizar el servicio cesará 
                                    inmediatamente.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>12. Ley Aplicable y Jurisdicción</h3>
                                <p class="text-muted">
                                    Estos Términos de Servicio se regirán e interpretarán de acuerdo con las leyes del país donde opera SecondHand. 
                                    Cualquier disputa relacionada con estos términos será sometida a la jurisdicción exclusiva de los tribunales competentes.
                                </p>
                            </div>

                            <div class="terms-section">
                                <h3>13. Contacto</h3>
                                <p class="text-muted">
                                    Si tienes preguntas sobre estos Términos de Servicio, puedes contactarnos a través de:
                                </p>
                                <ul class="terms-list text-muted">
                                    <li>Email: contacto@secondhand.com</li>
                                    <li>WhatsApp: +54 9 11 1234-5678</li>
                                    <li>Formulario de contacto en nuestra página web</li>
                                </ul>
                            </div>

                            <div class="highlight-box mt-5">
                                <p class="mb-0">
                                    <strong>Al utilizar SecondHand, reconoces que has leído, entendido y aceptas estar vinculado por estos Términos de Servicio.</strong>
                                </p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>


