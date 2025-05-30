namespace sap.capire.bookshop; 

using { Currency, 
        cuid,
        managed,
        Country,
        sap.common.CodeList  } from '@sap/cds/common';


entity Books : cuid, managed { 
  title  : localized String(111) @mandatory;
  descr  : localized String(1111);
  author : Association to Authors @mandatory @assert.target;
  genre  : Genre @assert.range: true;
  publCountry: Country;
  stock  : NoOfBooks default 0;
  price  : Price;
  isHardcover : Boolean;
}

type Genre: Integer enum{
  fiction = 1;
  non_fiction = 2;
}

type NoOfBooks : Integer;

type Price{
  amount: Decimal;
  currency: Currency;
}

entity Authors : cuid,managed { 
  name   : String(111);
  dateOfBirth : Date;
  dateOfDeath : Date;
  books  : Association to many Books on books.author = $self;
  epoch  : Association to Epochs @assert.target;
}

entity Epochs : CodeList { 
  key ID: Integer;
}
/** Hierarchically organized Code List for Genres */
// entity Genres : cuid, CodeList { 
//   parent   : Association to Genres;
//   children : Composition of many Genres on children.parent = $self;
// }

// extend Authors with MaagedObject;

aspect MaagedObject{
  createdAt: Timestamp;
  createdBy: String;
  
}
annotate Books with {
  modifiedAt @odata.etag
};
