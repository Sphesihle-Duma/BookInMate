from app import db

"""visitor model for creating a visitor table"""

class Visitor(db.Model):
    visitor_id = db.Column(db.String(255), primary_key=True)
    name = db.Column(db.String(255))
    email = db.Column(db.String(255))
    facility_id = db.Column(db.Integer, db.ForeignKey('facility.facility_id'))
    def __repr__(self):
        return f'<Visitor {self.name}>'

