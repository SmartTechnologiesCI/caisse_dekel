table 70009 "Depôt"
{
    DataCaptionFields = "N°", "N° client";
    fields
    {
        field(1; "N°"; Code[20])
        {
            trigger OnValidate()
            var
                caisse: Record "Parametres caisse";
            begin
                if "N°" <> xRec."N°" then begin
                    caisse.Get();
                    NoSeriesMgt.TestManual(caisse."N° souche Depot");
                    "No. Series" := '';
                    /*if xRec."No Point" = '' then
                        "Costing Method" := InvtSetup."Default Costing Method";*/
                end;
            end;
        }
        field(2; "Montant"; decimal)
        {
        }
        field(3; "Date"; Date)
        {
            Editable = false;
        }
        field(4; "Motif"; Text[100])
        {
        }
        field(5; "N° client"; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                client: Record Customer;
            begin
                client.SetRange("No.", "N° client");
                if client.FindFirst() then
                    "Nom du client" := client.Name;
            end;
        }
        field(7; "Mode de paiement"; code[50])
        {
            TableRelation = "Payment Method".Code;
        }
        field(8; "Nom du client"; code[50])
        {

        }
        field(9; "validated"; Boolean)
        {

        }
        field(10; "Code Caisse"; code[30])
        {
            Editable = false;
        }
        field(11; "User ID"; code[30])
        {
            Editable = false;
        }
        field(12; "Heure"; Time)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'N° Séries';
            Editable = false;
        }
        field(14; "isBonus"; Boolean)
        {
            CaptionML = ENU = 'is Bonus',
                        FRA = 'Bonus';
            //Editable = false;
        }

        field(15; "Origine Operation"; Code[50])
        {
            Caption = 'Origine opération';
            TableRelation = "Origine operation";
        }

        field(16; "Correction"; Boolean)
        {
            CaptionML = ENU = 'Validation',
                        FRA = 'Validation';
            //Editable = false;
        }

        // 07/03/2025 field(17; "DemandeApprobation"; Boolean)
        // {
        //     CaptionML = ENU = 'Demande approbation',
        //                 FRA = 'Demande approbation';
        //     //Editable = false;
        // }


    }

    keys
    {
        key(PK; "N°")
        {
            Clustered = true;
        }
    }

    var
        depot: Record Depôt;
        "parametre caisse": Record "Parametres caisse";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        caisse: Record Caisse;
        client: record customer;
    begin

        "parametre caisse".Reset();
        if "N°" = '' then begin
            if ("parametre caisse".Get()) then begin
                "parametre caisse".TestField("N° souche Depot");
                NoSeriesMgt.InitSeries("parametre caisse"."N° souche Depot", xRec."No. Series", 0D, "N°", "No. Series");
                //"Costing Method" := InvtSetup."Default Costing Method";
                "User ID" := UserId;
                caisse.SetRange("User ID", UserId);
                if (caisse.FindFirst()) then
                    "Code Caisse" := caisse."Code caisse";
                Heure := time;
                Date := WorkDate;
            end;
            client.SetRange("No.", "N° Client");
            if client.FindFirst() then
                "Nom du client" := client.Name;
        end;
    end;



    procedure AssistEdit_depot(OldPoint: Record "Depôt"): Boolean;
    var
        caisse: Record Caisse;
    begin
        WITH depot DO BEGIN
            depot := Rec;
            "parametre caisse".Get();
            "parametre caisse".TESTFIELD("N° souche Depot");
            IF NoSeriesMgt.SelectSeries("parametre caisse"."N° souche Depot", OldPoint."N°", "N°") THEN BEGIN
                "parametre caisse".Get();
                "parametre caisse".TESTFIELD("N° souche Depot");
                NoSeriesMgt.SetSeries("N°");
                Rec := depot;
                EXIT(true);
            END;
        END;
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