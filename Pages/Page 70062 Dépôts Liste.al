page 70062 "Dépôts Liste"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Depôt";
    CardPageId = 70014;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Liste des dépôts")
            {
                field("N°"; "N°")
                {
                    ApplicationArea = All;
                    AssistEdit = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Heure; Heure)
                {
                    ApplicationArea = All;

                }
                field("N° client"; "N° client")
                {
                    ApplicationArea = All;
                }
                field("Nom du client"; "Nom du client")
                {
                    ApplicationArea = All;
                }
                field(Motif; Motif)
                {
                    ApplicationArea = All;

                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field("Mode de paiement"; "Mode de paiement")
                {
                    ApplicationArea = All;
                }

                field("Origine Operation"; rec."Origine Operation")
                {
                    ApplicationArea = All;
                }
                field("Code Caisse"; "Code Caisse")
                {
                    ApplicationArea = All;

                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;

                }

                field(isBonus; isBonus)
                {
                    ApplicationArea = All;
                    Visible = false;
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
    var
        editable: Boolean;
        userPerso: record "User Personalization";

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetRange(Date, WorkDate);
        userPerso.Reset();
        userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            editable := userPerso."Profile ID" <> 'COMMERCIAL';
            CurrPage.Editable := editable;
        end;
        // SetRange(Date, WorkDate);
        SetCurrentKey(Date);
        SetAscending(Date, false);
    end;


    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            "Nom du client" := client.Name;
    end;
}