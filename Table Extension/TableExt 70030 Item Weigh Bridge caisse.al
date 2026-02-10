tableextension 70030 "Item Weigh Bridge caisse" extends "Item Weigh Bridge caisse"
{
    fields
    {
        field(4537; "Ticket annule"; Boolean)
        {
            CaptionML = ENU = 'Ticket cancelled', FRA = 'Ticket annulé';
            Description = 'Ticket annule';
        }

        field(4538; "Transporteur dekel"; Boolean)
        {
            CaptionML = ENU = 'Transporter dekel', FRA = 'Transporteur dekel';
            Description = 'Transporteur dekel';
        }

        field(2539; "Planteur paye"; Boolean)
        {
            CaptionML = ENU = 'Planter paid', FRA = 'Planteur paye';
            Description = 'Planteur paye';
        }

        field(2540; "Transporteur paye"; Boolean)
        {
            CaptionML = ENU = 'Transport paid', FRA = 'Transport payé';
            Description = 'Transporteur paye';
        }
        //<<Saber translate by Fab Smart 05_04_25
        field(2550; "Balance Code"; code[20])
        {
            CaptionML = ENU = 'Scale Code', FRA = 'Balance code';
            TableRelation = balance.Code;
        }
        field(2551; "Process Ticket"; Option)
        {
            OptionMembers = Validated,Create,Update;
            // Editable = false;
        }
        //<<Saber translate by Fab Smart 05_04_25
        //<<Fabrice Smart 05_03_25
        field(2552; "Client/Fournisseur"; CODE[50])
        {

        }

        field(20555; "Type Vehicule"; Code[50])
        {
            // OptionMembers = "Remorque","Tracteur";
        }
        field(50000; valide; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Posted', FRA = 'Validé';
        }
        field(50001; "Date validation"; Date)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Posted Date', FRA = 'Date validation';
        }
        field(50002; "Statut paiement"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statut paiement Transporteur';
        }
        field(50003; "Statut paiement Planteur"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statut paiement Planteur';
        }
        //FnGeek 04_09_25
        field(50004; CodeIncrementAuto; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(50005; CodeIncrementAuto2; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        //FnGeek 04_09_25
        //FnGeek 05_09_25
        field(50006; "Nombre de planteurs"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; MultiPese; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multipesé';
        }
        //FnGeek 
        field(50008; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Statut_Total_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entièrement payé';
        }
        field(50011; Ticket_Concerne; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s)';
        }
        field(50012; NuDocExtern; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; MontantNetPlanteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Montant Net Regime';
        }
        field(50014; MontantNetTransport; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Montant Net Transport';
        }
        field(55015; NumeroDocTransport; CODE[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Document Transport';
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
        myInt: Integer;
}