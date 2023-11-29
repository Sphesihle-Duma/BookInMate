from app import db

"""Booking model for creating a booking a table"""

class Booking(db.Model):
    booking_id = db.Column(db.Integer, primary_key=True)
    inmate_id = db.Column(db.Integer, db.ForeignKey('inmate.inmate_id'))
    visitor_id = db.Column(db.Integer, db.ForeignKey('visitor.visitor_id'))
    date = db.Column(db.Date)
    status = db.Column(db.String(50))
    timeslot = db.Column(db.String(50))
    email = db.Column(db.String(255))
    def __repr__(self):
        return f'<Booking {self.booking_id}>'
