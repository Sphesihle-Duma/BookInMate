from app import db

"""facility model for creating a facility table"""

class Facility(db.Model):
    facility_id = db.Column(db.String(255), primary_key=True)
    name = db.Column(db.String(255))
    location = db.Column(db.String(255))
    province = db.Column(db.String(255))
    def __repr__(self):
        return f'<Facility {self.name}>'
