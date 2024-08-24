page 70022 "Liste Ouverture Caisse"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Ouverture de caisse";
    Caption = 'Liste des ouvertures de caisse';
    Editable = false;
    CardPageId = 70023;
    SourceTableView = where(status = Filter(Validated | Opened));
    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field(No; No)
                {
                    ApplicationArea = All;
                    Caption = 'N°';

                }
                field(Date; "Date ouverture")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field(Heure; "Heure ouverture")
                {
                    ApplicationArea = All;
                    Caption = 'Heure';
                }
                field("Code caisse"; "Code caisse")
                {
                    ApplicationArea = All;
                    Caption = 'Code caisse';
                }
                field("User id"; "User id")
                {
                    ApplicationArea = All;
                    Caption = 'Utilisateur';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Montant calculé';
                    Visible = Billetage;
                }
                field(Amount2; Amount2)
                {
                    ApplicationArea = All;
                    Caption = 'Montant saisi';
                    Visible = NOT Billetage;
                }
                field(status; status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    var
        userperso: Record "User Personalization";
    begin
        userperso.SetRange("User ID", UserId);
        if userperso.FindFirst() then begin
            if (userperso."Profile ID" <> 'DIRECTEUR') then begin
                SetRange("User id", UserId);
            end;
        end;
    end;

    var
        myInt: Integer;
}