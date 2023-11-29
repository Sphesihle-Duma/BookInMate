from app import db
'''Inmate model for create inmate table'''
class Inmate(db.Model):
    inmate_id = db.Column(db.String(255), primary_key=True)
    name = db.Column(db.String(255))
    facility_id = db.Column(db.String(255), db.ForeignKey('facility.facility_id'))
    def __repr__(self):
        return f'<Inmate {self.name}>'


    
    
