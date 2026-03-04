/// @description Configuración de la Cámara

objetivo = obj_jugador; // El objeto que vamos a seguir
suavizado = 0.12;        // Qué tan rápido lo sigue (0.1 = 10% de la distancia por frame. 1 = instantáneo)

// Obtenemos el ID de la cámara que activamos en la Room
camara = view_camera[0];

// Leemos el ancho y alto que le configuraste a esa cámara
ancho_camara = camera_get_view_width(camara);
alto_camara = camera_get_view_height(camara);