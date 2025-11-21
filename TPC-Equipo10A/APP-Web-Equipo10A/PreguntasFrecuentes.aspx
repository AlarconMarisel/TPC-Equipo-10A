<%@ Page Title="Preguntas Frecuentes" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PreguntasFrecuentes.aspx.cs" Inherits="APP_Web_Equipo10A.PreguntasFrecuentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .faq-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }
        .faq-item {
            border: none;
            border-radius: 12px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .faq-header {
            background: white;
            border: none;
            border-radius: 12px;
            padding: 1.25rem 1.5rem;
            font-weight: 600;
            color: #212529;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .faq-header:hover {
            background: #f8f9fa;
        }
        .faq-header:not(.collapsed) {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .faq-body {
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 0 0 12px 12px;
        }
        .faq-icon {
            transition: transform 0.3s ease;
        }
        .faq-header:not(.collapsed) .faq-icon {
            transform: rotate(180deg);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="faq-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-5 fw-bold mb-3">Preguntas Frecuentes</h1>
                    <p class="lead mb-0">Encuentra respuestas a las preguntas más comunes sobre SecondHand</p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="mb-5">
                        <h2 class="fw-bold mb-4">Sobre la Compra</h2>
                        <div class="accordion" id="accordionCompra">
                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                    <span>¿Cómo puedo comprar un producto en SecondHand?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq1" class="collapse" data-bs-parent="#accordionCompra">
                                    <div class="faq-body">
                                        <p class="mb-0">Para comprar un producto, simplemente navega por nuestro catálogo, selecciona el artículo que te interese y haz clic en "Ver Artículo". Luego puedes agregarlo a tu carrito de reserva. Una vez que tengas todos los productos deseados, confirma tu reserva y realiza el pago de la seña (10% del valor total).</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                    <span>¿Qué es la seña y por qué debo pagarla?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq2" class="collapse" data-bs-parent="#accordionCompra">
                                    <div class="faq-body">
                                        <p class="mb-0">La seña es un pago inicial del 10% del valor total de tu compra que garantiza la reserva del producto. Este pago asegura que el artículo quede reservado para ti mientras completas el proceso de compra. La seña se descuenta del precio final cuando realizas el pago completo.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                    <span>¿Cuánto tiempo tengo para completar mi compra después de reservar?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq3" class="collapse" data-bs-parent="#accordionCompra">
                                    <div class="faq-body">
                                        <p class="mb-0">Tienes 72 horas desde el momento de la reserva para completar tu compra. Si no realizas el pago completo dentro de este período, la reserva puede ser cancelada y la seña no será reembolsable.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                    <span>¿Puedo cancelar mi reserva?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq4" class="collapse" data-bs-parent="#accordionCompra">
                                    <div class="faq-body">
                                        <p class="mb-0">No, no se puede cancelar una reserva. La seña no es reembolsable según nuestros términos y condiciones.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-5">
                        <h2 class="fw-bold mb-4">Sobre la Venta</h2>
                        <div class="accordion" id="accordionVenta">
                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq5">
                                    <span>¿Cómo puedo vender mis productos en SecondHand?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq5" class="collapse" data-bs-parent="#accordionVenta">
                                    <div class="faq-body">
                                        <p class="mb-0">Para vender productos, necesitas tener una cuenta de administrador. Si eres administrador, puedes acceder al Panel de Administración y agregar nuevos artículos con sus detalles, precios, categorías e imágenes. Una vez publicado, tu producto estará disponible para que los compradores lo vean y reserven.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq6">
                                    <span>¿Qué información necesito para publicar un producto?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq6" class="collapse" data-bs-parent="#accordionVenta">
                                    <div class="faq-body">
                                        <p class="mb-0">Necesitas proporcionar: nombre del producto, descripción detallada, precio, categoría, estado del artículo (Disponible, Reservado, Vendido) y al menos una imagen del producto. Cuanta más información y mejores imágenes proporciones, más atractivo será tu producto para los compradores.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq7">
                                    <span>¿Cómo se actualiza el estado de mi producto cuando se vende?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq7" class="collapse" data-bs-parent="#accordionVenta">
                                    <div class="faq-body">
                                        <p class="mb-0">Cuando un comprador completa el pago de su reserva, el sistema automáticamente actualiza el estado del producto a "Vendido" y se registra la venta. Como administrador, puedes ver todas las ventas realizadas en el panel de administración.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-5">
                        <h2 class="fw-bold mb-4">Preguntas Generales</h2>
                        <div class="accordion" id="accordionGeneral">
                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq8">
                                    <span>¿Necesito crear una cuenta para comprar?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq8" class="collapse" data-bs-parent="#accordionGeneral">
                                    <div class="faq-body">
                                        <p class="mb-0">Sí, necesitas crear una cuenta para realizar compras y reservas. El registro es gratuito y rápido. Solo necesitas proporcionar tu información básica y crear una contraseña segura.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq9">
                                    <span>¿Qué métodos de pago aceptan?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq9" class="collapse" data-bs-parent="#accordionGeneral">
                                    <div class="faq-body">
                                        <p class="mb-0">Actualmente aceptamos pagos mediante transferencia bancaria. Estamos trabajando para agregar más opciones de pago en el futuro.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq10">
                                    <span>¿Los productos tienen garantía?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq10" class="collapse" data-bs-parent="#accordionGeneral">
                                    <div class="faq-body">
                                        <p class="mb-0">Los productos de segunda mano se venden "tal cual" según su estado descrito. Recomendamos revisar cuidadosamente las descripciones y fotografías antes de realizar una compra. Si tienes dudas sobre el estado de un producto, puedes contactarnos antes de comprar.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-header w-100 text-start d-flex justify-content-between align-items-center collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq11">
                                    <span>¿Cómo puedo contactar con el soporte?</span>
                                    <span class="material-symbols-outlined faq-icon">expand_more</span>
                                </button>
                                <div id="faq11" class="collapse" data-bs-parent="#accordionGeneral">
                                    <div class="faq-body">
                                        <p class="mb-0">Puedes contactarnos a través de nuestro formulario de contacto en la página "Contacto", por WhatsApp al +54 9 11 1234-5678, o por email a contacto@secondhand.com. Estamos disponibles de lunes a viernes de 9:00 a 18:00.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-5 p-4 bg-light rounded-3">
                        <h3 class="fw-bold mb-3">¿No encontraste tu respuesta?</h3>
                        <p class="text-muted mb-4">Estamos aquí para ayudarte. Contáctanos y te responderemos lo antes posible.</p>
                        <a href="Contacto.aspx" class="btn btn-primary btn-lg rounded-pill px-5">Contáctanos</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>


