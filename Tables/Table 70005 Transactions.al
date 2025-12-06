table 70005 "Transactions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "N°"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Source"; Enum Source)
        {

        }
        field(3; "Date"; Date)
        {

        }
        field(4; "Heure"; Time)
        {

        }
        field(5; "Description"; Text[100])
        {

        }
        field(6; "Montant"; Decimal)
        {

        }
        field(7; "Montant recu"; Decimal)
        {

        }
        field(8; "Montant rendu"; Decimal)
        {

        }

        field(9; "Code caisse"; code[20])
        {
            TableRelation = Caisse."Code caisse";
        }
        field(10; "N° Client"; code[20])
        {
            TableRelation = Vendor."No.";
            Caption = 'Planteur/Transporteur';

            trigger OnValidate()
            var
                client: record customer;
            begin
                client.SetRange("No.", "N° Client");
                if client.FindFirst() then
                    Nom := client.Name;
            end;
        }
        field(11; "N° Document"; code[20])
        {

        }
        field(12; "Mode de reglement"; code[20])
        {
            TableRelation = "Payment Method".Code;
        }
        field(13; "user id"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(14; "recouvrement"; Boolean)
        {

        }
        field(15; "Nom"; Text[50])
        {
        }
        field(16; "validée"; Boolean)
        {
        }
        field(17; "Montant restant"; Decimal)
        {
        }
        field(18; "Montant NET"; Decimal)
        {
        }
        field(19; "cancel"; Boolean)
        {
        }
        field(20; "Origine Operation"; Code[50])
        {
            Caption = 'Origine opération';
            // TableRelation = "Origine operation";
        }
        field(21; DocExtern; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(22; Multipaiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multi-Paiement';
        }


    }

    keys
    {
        key(PK; "N°")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()

    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            Nom := client.Name;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}