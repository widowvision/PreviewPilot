# from flask import Flask, jsonify
import cv2
import numpy as np
# app = Flask(__name__)

# @app.route('/api/data', methods=['GET'])
# def get_data():
#     data = {'message': 'Hello from Python backend!'}
#     return jsonify(data)

# if __name__ == '__main__':
#     app.run(debug=True)

image = cv2.imread('./assets/images/pegboard.png')
image = cv2.medianBlur(image,5)
output = image.copy()
# print(image.dtype)

image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
# image = cv2.GaussianBlur(image,(5,5),0)
cv2.resize(image, None, fx=50, fy=50, interpolation=cv2.INTER_LINEAR)
cv2.imshow('Image', image)
circles = cv2.HoughCircles(image, cv2.HOUGH_GRADIENT,1,100, param1=2, param2=2)
print("Circles", circles)
if circles is not None:
    circles = np.round(circles[0, :]).astype("int")
    for (x, y, r) in circles:
        # draw the circle in the output image, then draw a rectangle
        # corresponding to the center of the circle
        cv2.circle(image, (x, y), r, (0, 255, 0), 4)
        cv2.rectangle(image, (x - 5, y - 5), (x + 5, y + 5), (0, 128, 255), -1)
    # show the output image
    cv2.imshow("output", image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
else:
    print("No circles detected.")