
USE E_COMMERCE_DB
GO

-- =============================================
-- ARTICULOS
-- =============================================
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Heladera', 'Heladera Gafa con Frizzer', 100000.00, 3, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Mesa Ratona', 'Mesa ratona en excelente estado de 60X100 cm', 50000.00, 2, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Set Posillos', 'Set de 4 Posillos con platito, poco uso', 10000.00, 4, 2, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Batidora de mano', 'Batidora de mano, potente y duradera. Estado fantastica.', 55000.00, 3, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Cama 1 plaza', 'Comodidad y estilo para dormir, descansar, leer tu libro preferido o mirar una serie en la televisión.', 75000.00, 2, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Biblioteca Grande', 'Biblioteca madera, 2m alto x 1,5m ancho', 65000.00, 2, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Lavarropa LG', 'Capacidad de 8.5 kg: ideal para familias, lava grandes cargas de ropa', 320000.00, 3, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Freidora de Aire', 'Descubre la Airfryer XL Philips, un electrodoméstico que transforma la forma de cocinar. Con su innovadora tecnología Rapid Air, podrás disfrutar de comidas crujientes y deliciosas con menos aceite.', 650900.00, 3, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Bodega de Madera', 'Bodega hierro y madera para 18 botellas, 82cm CM alto, 35CM ancho y 30 CM fondo.', 65000.00, 2, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Alacena Madera', 'Dimensiones de la alacena: 160cm de alto, 60cm de ancho, 30cm de profundidad.', 40000.00, 2, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Multiprocesadora', 'Potencia: 750 W.', 120000.00, 3, 1, 0);
INSERT INTO ARTICULOS(Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) VALUES ('Placard/Ropero', 'Placar fabricado en melamina es una excelente opción si buscás un mueble de alta durabilidad y resistente a posibles daños ocasionados por la humedad y los animales', 80000.00, 2, 1, 0);

-- =============================================
-- IMAGENES
-- =============================================

INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (1, 'Content/Uploads/Articulos/HeladeraGafaFreezer01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (2, 'Content/Uploads/Articulos/MesaRatona01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (3, 'Content/Uploads/Articulos/SetPosillos01.jpg');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (4, 'Content/Uploads/Articulos/articulo_4_638985007111572588_BatidoraOster01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (4, 'Content/Uploads/Articulos/articulo_4_638985007111637826_BatidoraOster02.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (4, 'Content/Uploads/Articulos/articulo_4_638985020088861124_BatidoraOster04.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (4, 'Content/Uploads/Articulos/articulo_4_638985021484462831_BatidoraOster03.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (4, 'Content/Uploads/Articulos/articulo_4_638985022118191448_BatidoraOster05.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (5, 'Content/Uploads/Articulos/articulo_5_638985385615817375_CamaUnaPlaza01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (5, 'Content/Uploads/Articulos/articulo_5_638985385615890915_CamaUnaPlaza02.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (5, 'Content/Uploads/Articulos/articulo_5_638985385615890915_CamaUnaPlaza03.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (6, 'Content/Uploads/Articulos/articulo_6_638985387823335381_BibliotecaMadera01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (7, 'Content/Uploads/Articulos/articulo_7_638985389219279191_LavarropaLG01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (8, 'Content/Uploads/Articulos/articulo_8_638985390693964384_FreidoraAire01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (9, 'Content/Uploads/Articulos/articulo_9_638985391922577619_BodegaVino01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (10, 'Content/Uploads/Articulos/articulo_10_638985393839969345_AlacenaCocina01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (11, 'Content/Uploads/Articulos/articulo_11_638985395196158371_Multiprocesadora01.webp');
INSERT INTO IMAGENESARTICULO(IDArticulo, RutaImagen) VALUES (12, 'Content/Uploads/Articulos/articulo_12_638985397248105318_PlacarRopero01.webp');


