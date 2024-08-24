table 70013 "Encaissement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "N°"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "N° commande"; code[20])
        {

        }
        field(3; "N° client"; code[20])
        {

        }
        field(14; "Nom client"; Text[250])
        {

        }
        field(4; "Mode de paiement"; code[20])
        {

        }
        field(5; "NET a payer"; Decimal)
        {

        }
        field(6; "Montant NET"; Decimal)
        {

        }
        field(7; "Montant"; Decimal)
        {

        }
        field(8; "Monnaie"; Decimal)
        {

        }
        field(9; "Reste"; Decimal)
        {

        }
        field(10; "Validé"; Boolean)
        {

        }
        field(11; "Date"; Date)
        {

        }
        field(12; "Heure"; Time)
        {

        }

        field(13; "Code caisse"; code[30])
        {

        }

        field(15; "cancel"; Boolean)
        {

        }
        field(16; "Epargne"; Decimal)
        {

        }
        field(50037;Approuve;Boolean){
            
        }
        field(50038; NbImpression;Integer){
            
        }
        //smart olivirt
       /* field(17; "payer_Depot"; Decimal)
        {

        }*/
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
    begin

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