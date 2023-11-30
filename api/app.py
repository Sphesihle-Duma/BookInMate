from flask import Flask, request, jsonify,  make_response
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Message, Mail
from flask_cors import CORS
import uuid
import logging




app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "http://127.0.0.1:5000"}})


app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://booking_test:3ID2h:44@localhost/booking_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['MAIL_SERVER']="smtp.gmail.com"
app.config['MAIL_PORT']=465
app.config['MAIL_USERNAME']="dumasphesihle22@gmail.com"
app.config['MAIL_PASSWORD']='flsn mstv pqgt lnvp'
app.config['MAIL_USE_TLS']=False
app.config['MAIL_USE_SSL']=True

mail = Mail(app)


db = SQLAlchemy(app)


@app.route('/api/booking', methods=['POST'])
def create_booking():
    from models.booking import Booking
    from models.visitor import Visitor
    from models.facility import Facility
    from models.inmate import Inmate
    data = request.get_json()
    required_params = ['inmate_id', 'visitor_id', 'date', 'timeslot', 'facility_id', 'name', 'email']
    if not all(param in data for param in required_params):
        return jsonify({'error': 'Missing required parameters'}), 400
    try:
        new_visitor = Visitor(
        visitor_id = data['visitor_id'],
        email = data['email'],
        name = data['name'],
        facility_id = data['facility_id']
        )
        db.session.add(new_visitor)
        db.session.commit()
        new_booking = Booking(
            booking_id = str(uuid.uuid4()),
            inmate_id=data['inmate_id'],
            visitor_id=data['visitor_id'],
            date=data['date'],
            timeslot=data['timeslot'],
            status='Pending',
            email=data['email']
        )
        db.session.add(new_booking)
        db.session.commit()

        return jsonify({'message':'Booking created successfully'}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": f'Error creating booking: {str(e)}'}), 500
    
@app.route('/api/facilities')
def get_facility():
    from models.facility import Facility
    facility_ids = [row[0] for row in db.session.query(Facility.facility_id).all()]
    return jsonify(facility_ids)

@app.route('/api/all_bookings')
def get_all_bookings():
    from models.booking import Booking
    bookings = db.session.query(Booking).all()
    app.logger.info("fetching all records from booking table")
    bookings_list = [
        {
            "booking_id": booking.booking_id,
            "inmate_id": booking.inmate_id,
            "visitor_id": booking.visitor_id,
            "date": booking.date,
            "timeslot": booking.timeslot,
            "status": booking.status,
            "email": booking.email
        }
            for booking in bookings
        ]
    return jsonify(bookings_list)


@app.route('/api/update_booking_status', methods=['PUT'])
def update_booking_status():
    from models.booking import Booking
    from models.inmate import Inmate
    from models.visitor import Visitor
    
    # Get the booking_id and new status from the request
    data = request.get_json()
    booking_id = data.get('booking_id')
    new_status = data.get('new_status')
    recipient_email = data.get('email')
    app.logger.info(f"Recieved data: {data}")
    # Check if booking_id and new_status are provided
    if not data or 'booking_id' not in data or "new_status" not in data or "email" not in data:
        return jsonify({'error': 'Invalid request payload'}), 400

    # Query the database to find the booking by booking_id
    booking = db.session.query(Booking).filter_by(booking_id=booking_id).first()

    # Check if the booking exists
    if not booking:
        return jsonify({'error': 'Booking not found'}), 404

    # Update the booking status to the new status
    booking.status = new_status
    
    try:
        # Commit the changes to the database
        db.session.commit()
        

        if not recipient_email:
            return jsonify({'error': 'Missing recipient_email parameter'}), 400

        mail_message = Message(
            'Booking Approval',
            sender="dumasphesihle22@gmail.com",
            recipients=[recipient_email]
        )
        mail_message.body = "This is a test"
        app.logger.info("sending the email")
        mail.send(mail_message)

        return jsonify({'message': 'Successfully sent the email'}), 200
    except Exception as e:
        # Rollback in case of an error
        db.session.rollback()
        return jsonify({"error": f'The email was not sent: {str(e)}'}), 500

    
if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5001)
