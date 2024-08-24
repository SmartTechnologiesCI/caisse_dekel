page 70083 "Objectif Details"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Objectif Commercial";
    Editable = false;
    Caption = 'Information';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(commercial; commercial)
                {
                    Caption = 'ID Utilisateur';
                }
                field("Salesperson code"; "Salesperson code")
                {
                    Caption = 'Code Commercial';
                }
                field(Groupe; teamSalesPerson."Team Code")
                {
                    CaptionML = ENU = 'Team', FRA = 'Groupe';
                    Editable = false;
                }
                field(dateDebut; rec.dateDebut)
                {
                    Editable = false;
                }
                field(DateFin; rec.DateFin)
                {
                    Editable = false;
                }

            }
            part(ObjectifCommercial; "ObjectifCommercial subform")
            {
                Editable = false;

                SubPageLink = "No Task" = field(No);
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        userSetup.SetRange("User ID", UserId);
        if userSetup.FindFirst() then begin
            assignedUserId := userSetup."User ID";
            teamSalesPerson.SetRange("Salesperson Code", userSetup."Salespers./Purch. Code");
            if teamSalesPerson.FindFirst() then begin
                commercial := assignedUserId;
                "Salesperson code" := teamSalesPerson."Salesperson Code";

                objectif.SetRange(Groupe, teamSalesPerson."Team Code");
                if objectif.FindFirst() then begin
                    //dateDebut := objectif.DateDebut;
                    //DateFin := objectif.DateFin;
                    //"No task" := objectif.No;
                    rec.No := objectif.No;

                end;
            end;
        end;
        ;





    end;



    var
        myInt: Integer;
        teamSalesPerson: Record "Team Salesperson";
        salesCode: Code[20];
        dateDebut: Date;
        DateFin: Date;
        userSetup: Record "User Setup";
        Groupe: Text[250];
        objectif: Record "Objectif Commercial";
        "No task": Code[30];
        commercial: Text[200];
        "Salesperson code": Code[30];
        assignedUserId: Text[50];
}