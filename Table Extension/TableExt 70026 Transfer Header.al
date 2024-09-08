tableextension 70026 "Transfer HeaderExt" extends "Transfer Header"
{
    fields
    {
        field(50000; "PoidsActuelmagasinOrigine"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Poids Actuel du magasin Origine';
        }
        field(50001; "CartonsActuelmagasinOrigine"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cartons Actuel du magasin Origine';
        }
        field(50002; "PoisActuelMagasinDestination"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Poids Actuel du magasin Destination';

        }
        field(50003; "CartonsActuelMagasinDestinat."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cartons Actuel du magasin Destination';
        }
        field(50004; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(50005; Description; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Cartons total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Qunatité Totale"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Decimal;
}