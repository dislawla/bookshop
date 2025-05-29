namespace sap.capire.bookshop; 

using { Currency, 
        cuid,
        managed,
        Country,
        sap.common.CodeList  } from '@sap/cds/common';


entity Books : cuid, managed { 
  title  : localized String(111)@mandatory;
  descr  : localized String(1111);
  author : Association to Authors@mandatory @assert.target;
  genre  : Association to Genres;
  publCountry: Country;
  stock  : NoOfBooks;
  price  : Price;
  isHardcover : Boolean;
}

type NoOfBooks : Integer;

type Price{
  amount: Decimal;
  currency: Currency;
}

entity Authors : cuid, { 
  name   : String(111);
  books  : Association to many Books on books.author = $self;
  epoch  : Association to Epochs;
}

entity Epochs : CodeList { 
  key ID: Integer;
}
/** Hierarchically organized Code List for Genres */
entity Genres : cuid, CodeList { 
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}

extend Authors with MaagedObject;

aspect MaagedObject{
  createdAt: Timestamp;
  createdBy: String;
  
}
annotate Books with {
  modifiedAt @odata.etag
};
