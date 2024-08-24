page 70081 "Objectif Commercial card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Objectif Commercial";
    Caption = 'Modifier Objectif Commercial';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No) { }
                field(Groupe; rec.Groupe)
                {
                    Editable = Rec.Status <> Rec.Status::Termine;
                }

                field(DateDebut; rec.DateDebut)
                {
                    // Editable = Rec.Status <> Rec.Status::Termine;
                    Editable = false;
                }
                field(DateFin; rec.DateFin)
                {
                    // Editable = Rec.Status <> Rec.Status::Termine;
                    Editable = false;
                }
                field(Priority; rec.Priority)
                {
                    Editable = Rec.Status <> Rec.Status::Termine;
                    Visible = false;

                }

                field(Type; rec.isPerformance)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    Editable = Rec.Status <> Rec.Status::Termine;
                    Visible = false;

                }
                field(Prime; rec."Prime du groupe")
                {
                    Visible = false;

                }

                field(tailleGroupe; rec.tailleGroupe)
                {

                }
                field(Description; rec.Description)
                {
                    Editable = Rec.Status <> Rec.Status::Termine;
                }
                field("Type de groupe"; rec."Type de groupe")
                {

                }




            }
            part(ObjectifCommercial; "ObjectifCommercial subform")
            {
                Caption = 'Objectif Vente';

                SubPageLink = "No Task" = field("No");
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Attribution)
            {
                Caption = 'Attribuer Objectif';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Apply;
                Visible = false;

                trigger OnAction()
                begin
                    rec.Status := Rec.Status::"En Cours";
                end;
            }
            action(Modification)
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = false;
                Caption = 'Modifier';


                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if (rec.Status <> rec.Status::Termine) and (WorkDate() < rec.DateFin) then begin
                        Rec.Status := Rec.Status::"En Cours";
                    end else begin
                        Error(msgObjectifTermine);
                    end;
                    ;
                end;

            }

        }
    }

    trigger OnQueryClosePage(CloseAction: action): Boolean
    var
        myInt: Integer;
    begin
        /*      if CloseAction = CloseAction::OK then begin
                 if (Format(rec.DateDebut) = '') or (Format(rec.DateDebut) = '') then begin
                     Error('Une date est necessaire');
                 end;

                 if rec.DateDebut > rec.DateFin then begin
                     Error('Date debut est superieur a la date de fin');
                 end;
             end; */
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec.DateDebut := DMY2Date(01, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3));
        rec.DateFin := CalcDate('+1M -1J', DMY2Date(01, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3)));
    end;

    var
        myInt: Integer;
        usertask: Record "User Task";
        msgObjectifTermine: TextConst FRA = 'Impossible de modifié tache deja terminé';

}