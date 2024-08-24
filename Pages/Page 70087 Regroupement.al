page 70087 Regroupement
{
    PageType = ReportProcessingOnly;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'regroupement';
    //SourceTable = TableName;

    layout
    {
        area(Content)
        {
            field("Equipe"; team.Code)
            {
                TableRelation = Team.Code;
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
            action("Regroupement G1")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
        ocom: Record "Objectif Commercial";
        ocom2: Record "Objectif Commercial";

        ligneOcomm: Record "Ligne Ojectif Commercial";
        ligneOcomm2: Record "Ligne Ojectif Commercial";
    begin
        if (CloseAction = CloseAction::OK) then begin
            ocom.SetRange(Groupe, team.Code);


            if ocom.FindFirst() then begin
                if ocom2.no = '' then
                    ocom2.No := ocom.No;


                repeat
             
                    ligneOcomm.Reset();
                    ligneOcomm.SetRange("No Task", ocom.No);
                    ligneOcomm.SetFilter("Date debut", '>=%1', DMY2Date(01, 03, 2022));
                    //ligneOcomm.SetFilter("Date fin", '<=%1', DMY2Date(31, 03, 2022));

                    if ligneOcomm.FindFirst() then begin

                        repeat
                            ligneOcomm."No Task" := ocom2.No;
                            ligneOcomm.Modify();
                        //Commit();

                        until ligneOcomm.Next() = 0;

                    end;


                until ocom.Next() = 0;


                Message('Mise a jour de %1 le nouveau doc est : %2', team.Code, ocom2.No);
            end;


        end;
    end;

    var
        myInt: Integer;
        team: Record Team;
}