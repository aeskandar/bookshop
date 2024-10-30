using { Currency, managed, sap, cuid } from '@sap/cds/common';
namespace io.eskandar.bookshop;

@cds.search: { title }
entity Books : cuid, managed {
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  genre  : Association to Genres;
  stock  : Integer;
  price  : Decimal(9,2);
  availability: String(20);
  currency : Currency;
}

entity Authors : cuid, managed {
  name   : String(111);
  books  : Composition of many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}