var _zoom_amount = cam1.zoom_amount;
_zoom_amount -= 0.05;
_zoom_amount = clamp(_zoom_amount, 0.1, 2);
cam1.zoom(_zoom_amount, 0);