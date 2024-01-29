from sqlalchemy import TIMESTAMP, Column, DateTime, Float, ForeignKey, String, Table, Text, text
from sqlalchemy.dialects.mysql import BIGINT, INTEGER, MEDIUMTEXT, TINYINT
from sqlalchemy.orm import DeclarativeMeta, declarative_base, relationship

# see: https://github.com/python/mypy/issues/2477#issuecomment-703142484
Base: DeclarativeMeta = declarative_base()

metadata = Base.metadata

t_BuildType = Table(
    'BuildType', metadata,
    Column('Name', String(30), nullable=False)
)

class DefinitionTable(Base):
    __tablename__ = 'definitionTable'

    ID = Column(BIGINT(20), primary_key=True)
    name = Column(String(255), nullable=False)


class Dictionary(Base):
    __tablename__ = 'dictionary'

    ID = Column(BIGINT(20), primary_key=True)
    tableId = Column(ForeignKey('definitionTable.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    contentId = Column(BIGINT(20), nullable=False, index=True)
    content = Column(MEDIUMTEXT, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    language = relationship('Language', primaryjoin='Dictionary.languageId == Language.ID')
    definitionTable = relationship('DefinitionTable')


class Language(Base):
    __tablename__ = 'language'

    ID = Column(BIGINT(20), primary_key=True)
    isoLang = Column(String(2), nullable=False)
    name = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    dictionary = relationship('Dictionary', primaryjoin='Language.name == Dictionary.contentId')


class Patient(Base):
    __tablename__ = 'patient'

    ID = Column(BIGINT(20), primary_key=True)
    hospitalId = Column(BIGINT(20), nullable=False, index=True)
    externalId = Column(INTEGER(11), nullable=False, index=True, comment='OpalDB.Patient.PatientSerNum')
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False)
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)


class Library(Base):
    __tablename__ = 'library'

    ID = Column(BIGINT(20), primary_key=True)
    OAUserId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    name = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))
    private = Column(TINYINT(4), nullable=False, server_default=text('0'))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    dictionary = relationship('Dictionary')


class Purpose(Base):
    __tablename__ = 'purpose'

    ID = Column(BIGINT(20), primary_key=True)
    title = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)

    dictionary = relationship('Dictionary', primaryjoin='Purpose.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Purpose.title == Dictionary.contentId')


class Respondent(Base):
    __tablename__ = 'respondent'

    ID = Column(BIGINT(20), primary_key=True)
    title = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)

    dictionary = relationship('Dictionary', primaryjoin='Respondent.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Respondent.title == Dictionary.contentId')


class Tag(Base):
    __tablename__ = 'tag'

    ID = Column(BIGINT(20), primary_key=True)
    tag = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    dictionary = relationship('Dictionary')


class Type(Base):
    __tablename__ = 'type'

    ID = Column(BIGINT(20), primary_key=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    tableId = Column(ForeignKey('definitionTable.ID'), nullable=False, index=True)
    subTableId = Column(ForeignKey('definitionTable.ID'), nullable=False, index=True)
    templateTableId = Column(ForeignKey('definitionTable.ID'), nullable=False, index=True)
    templateSubTableId = Column(ForeignKey('definitionTable.ID'), nullable=False, index=True)

    dictionary = relationship('Dictionary')
    definitionTable = relationship('DefinitionTable', primaryjoin='Type.subTableId == DefinitionTable.ID')
    definitionTable1 = relationship('DefinitionTable', primaryjoin='Type.tableId == DefinitionTable.ID')
    definitionTable2 = relationship('DefinitionTable', primaryjoin='Type.templateSubTableId == DefinitionTable.ID')
    definitionTable3 = relationship('DefinitionTable', primaryjoin='Type.templateTableId == DefinitionTable.ID')


class LegacyType(Base):
    __tablename__ = 'legacyType'
    __table_args__ = {'comment': 'This table is a direct replication from the legacy table QuestionType in questionnaireDB. It is required for the time of the migration. When the migration will be over and the triggers will stop, this table needs to be deleted.'}

    ID = Column(BIGINT(20), primary_key=True)
    legacyName = Column(String(255), nullable=False)
    legacyTableName = Column(String(255), nullable=False)
    typeId = Column(ForeignKey('type.ID'), nullable=False, index=True)
    default = Column(TINYINT(4), nullable=False, server_default=text('0'))

    type = relationship('Type')


class Questionnaire(Base):
    __tablename__ = 'questionnaire'

    ID = Column(BIGINT(20), primary_key=True)
    OAUserId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    purposeId = Column(ForeignKey('purpose.ID'), nullable=False, index=True, server_default=text('1'))
    respondentId = Column(ForeignKey('respondent.ID'), nullable=False, index=True, server_default=text('1'))
    title = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    nickname = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    category = Column(INTEGER(11), nullable=False, server_default=text('-1'))
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    instruction = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    final = Column(TINYINT(4), nullable=False, server_default=text('0'))
    version = Column(INTEGER(11), nullable=False, server_default=text('1'))
    parentId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    private = Column(TINYINT(4), nullable=False, server_default=text('0'))
    optionalFeedback = Column(TINYINT(4), nullable=False, server_default=text('1'))
    visualization = Column(TINYINT(4), nullable=False, server_default=text('0'), comment='0 = regular view of the answers, 1 = graph')
    logo = Column(String(512), nullable=False, server_default=text("''"))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)
    legacyName = Column(String(255), nullable=False, server_default=text("''"), comment='This field is mandatory to make the app works during the migration process. This field must be removed once the migration of the legacy questionnaire will be done, the triggers stopped and the app changed to use the correct standards.')

    dictionary = relationship('Dictionary', primaryjoin='Questionnaire.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Questionnaire.instruction == Dictionary.contentId')
    dictionary2 = relationship('Dictionary', primaryjoin='Questionnaire.nickname == Dictionary.contentId')
    purpose = relationship('Purpose')
    respondent = relationship('Respondent')
    dictionary3 = relationship('Dictionary', primaryjoin='Questionnaire.title == Dictionary.contentId')


class TagLibrary(Base):
    __tablename__ = 'tagLibrary'

    ID = Column(BIGINT(20), primary_key=True)
    tagId = Column(ForeignKey('tag.ID'), nullable=False, index=True)
    libraryId = Column(ForeignKey('library.ID'), nullable=False, index=True)

    library = relationship('Library')
    tag = relationship('Tag')


class TemplateQuestion(Base):
    __tablename__ = 'templateQuestion'

    ID = Column(BIGINT(20), primary_key=True)
    OAUserId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    name = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    typeId = Column(ForeignKey('type.ID'), nullable=False, index=True)
    version = Column(INTEGER(11), nullable=False, server_default=text('0'))
    parentId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    polarity = Column(TINYINT(4), nullable=False, server_default=text('0'))
    private = Column(TINYINT(4), nullable=False, server_default=text('0'))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    dictionary = relationship('Dictionary')
    type = relationship('Type')



class AnswerQuestionnaire(Base):
    __tablename__ = 'answerQuestionnaire'

    ID = Column(BIGINT(20), primary_key=True)
    questionnaireId = Column(ForeignKey('questionnaire.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    respondentUsername = Column(String(255), nullable=False, server_default=text("''"), comment='Firebase username of the user who answered (or is answering) the questionnaire')
    respondentDisplayName = Column(String(255), nullable=False, server_default=text("''"), comment='First name and last name of the respondent for display purposes.')
    status = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='0 = New, 1 = In Progress, 2 = Completed')
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False)
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    patient = relationship('Patient')
    questionnaire = relationship('Questionnaire')


class Question(Base):
    __tablename__ = 'question'

    ID = Column(BIGINT(20), primary_key=True)
    OAUserId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    display = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    definition = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    question = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    typeId = Column(ForeignKey('type.ID'), nullable=False, index=True)
    version = Column(INTEGER(11), nullable=False, server_default=text('1'))
    parentId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    polarity = Column(TINYINT(4), nullable=False, server_default=text('0'), comment='0 = lowGood (the lower the score, the better the answer), 1 = highGood (the higher the score, the better the answer)')
    private = Column(TINYINT(4), nullable=False, server_default=text('0'))
    final = Column(TINYINT(4), nullable=False, server_default=text('0'))
    optionalFeedback = Column(TINYINT(4), nullable=False, server_default=text('0'))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)
    legacyTypeId = Column(ForeignKey('legacyType.ID'), nullable=False, index=True, comment='This ID linked to the legacyTypes table must be removed once the migration of the legacy questionnaire will be done and the triggers stopped.')

    dictionary = relationship('Dictionary', primaryjoin='Question.definition == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Question.display == Dictionary.contentId')
    legacyType = relationship('LegacyType')
    dictionary2 = relationship('Dictionary', primaryjoin='Question.question == Dictionary.contentId')
    type = relationship('Type')


class QuestionnaireFeedback(Base):
    __tablename__ = 'questionnaireFeedback'

    ID = Column(BIGINT(20), primary_key=True)
    questionnaireId = Column(ForeignKey('questionnaire.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    feedback = Column(Text, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    language = relationship('Language')
    patient = relationship('Patient')
    questionnaire = relationship('Questionnaire')


class QuestionnaireRating(Base):
    __tablename__ = 'questionnaireRating'

    ID = Column(BIGINT(20), primary_key=True)
    questionnaireId = Column(ForeignKey('questionnaire.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    rating = Column(INTEGER(11), nullable=False, server_default=text('0'))
    comment = Column(Text, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    language = relationship('Language')
    patient = relationship('Patient')
    questionnaire = relationship('Questionnaire')


class Section(Base):
    __tablename__ = 'section'

    ID = Column(BIGINT(20), primary_key=True)
    questionnaireId = Column(ForeignKey('questionnaire.ID'), nullable=False, index=True)
    title = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    instruction = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    dictionary = relationship('Dictionary', primaryjoin='Section.instruction == Dictionary.contentId')
    questionnaire = relationship('Questionnaire')
    dictionary1 = relationship('Dictionary', primaryjoin='Section.title == Dictionary.contentId')


class TemplateQuestionCheckbox(Base):
    __tablename__ = 'templateQuestionCheckbox'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)
    minAnswer = Column(INTEGER(11), nullable=False, server_default=text('0'))
    maxAnswer = Column(INTEGER(11), nullable=False, server_default=text('0'))

    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionDate(Base):
    __tablename__ = 'templateQuestionDate'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)

    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionLabel(Base):
    __tablename__ = 'templateQuestionLabel'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)
    displayIntensity = Column(INTEGER(11), nullable=False, server_default=text('0'))
    pathImage = Column(String(512), nullable=False)

    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionRadioButton(Base):
    __tablename__ = 'templateQuestionRadioButton'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)

    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionSlider(Base):
    __tablename__ = 'templateQuestionSlider'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)
    minValue = Column(Float, nullable=False)
    maxValue = Column(Float, nullable=False)
    minCaption = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    maxCaption = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    increment = Column(Float, nullable=False)

    dictionary = relationship('Dictionary', primaryjoin='TemplateQuestionSlider.maxCaption == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='TemplateQuestionSlider.minCaption == Dictionary.contentId')
    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionTextBox(Base):
    __tablename__ = 'templateQuestionTextBox'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)

    templateQuestion = relationship('TemplateQuestion')


class TemplateQuestionTime(Base):
    __tablename__ = 'templateQuestionTime'

    ID = Column(BIGINT(20), primary_key=True)
    templateQuestionId = Column(ForeignKey('templateQuestion.ID'), nullable=False, index=True)

    templateQuestion = relationship('TemplateQuestion')


class AnswerSection(Base):
    __tablename__ = 'answerSection'

    ID = Column(BIGINT(20), primary_key=True)
    answerQuestionnaireId = Column(ForeignKey('answerQuestionnaire.ID'), nullable=False, index=True)
    sectionId = Column(ForeignKey('section.ID'), nullable=False, index=True)

    answerQuestionnaire = relationship('AnswerQuestionnaire')
    section = relationship('Section')

class Checkbox(Base):
    __tablename__ = 'checkbox'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    minAnswer = Column(INTEGER(11), nullable=False, server_default=text('1'))
    maxAnswer = Column(INTEGER(11), nullable=False, server_default=text('1'))

    question = relationship('Question')


class Date(Base):
    __tablename__ = 'date'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)

    question = relationship('Question')


class Label(Base):
    __tablename__ = 'label'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    displayIntensity = Column(TINYINT(4), nullable=False, server_default=text('0'), comment='0 = patient cannot select intensity, 1 = patient can select intensity')
    pathImage = Column(String(512), nullable=False)

    question = relationship('Question')


class LibraryQuestion(Base):
    __tablename__ = 'libraryQuestion'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    libraryId = Column(ForeignKey('library.ID'), nullable=False, index=True)

    library = relationship('Library')
    question = relationship('Question')


class QuestionFeedback(Base):
    __tablename__ = 'questionFeedback'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    feedback = Column(Text, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    language = relationship('Language')
    patient = relationship('Patient')
    question = relationship('Question')


class QuestionRating(Base):
    __tablename__ = 'questionRating'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    rating = Column(INTEGER(11), nullable=False, server_default=text('0'))
    comment = Column(Text, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    language = relationship('Language')
    patient = relationship('Patient')
    question = relationship('Question')


class QuestionSection(Base):
    __tablename__ = 'questionSection'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    sectionId = Column(ForeignKey('section.ID'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))
    orientation = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='0 = Portrait, 1 = Landscape, 2 = Both')
    optional = Column(TINYINT(4), nullable=False, server_default=text('0'), comment='0 = false, 1 = true')

    question = relationship('Question')
    section = relationship('Section')


class RadioButton(Base):
    __tablename__ = 'radioButton'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)

    question = relationship('Question')


class Slider(Base):
    __tablename__ = 'slider'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    minValue = Column(Float, nullable=False)
    maxValue = Column(Float, nullable=False)
    minCaption = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    maxCaption = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    increment = Column(Float, nullable=False)

    dictionary = relationship('Dictionary', primaryjoin='Slider.maxCaption == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Slider.minCaption == Dictionary.contentId')
    question = relationship('Question')



class TagQuestion(Base):
    __tablename__ = 'tagQuestion'

    ID = Column(BIGINT(20), primary_key=True)
    tagId = Column(ForeignKey('tag.ID'), nullable=False, index=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)

    question = relationship('Question')
    tag = relationship('Tag')


class TemplateQuestionCheckboxOption(Base):
    __tablename__ = 'templateQuestionCheckboxOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('templateQuestionCheckbox.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))
    specialAction = Column(INTEGER(11), nullable=False, comment='0 = nothing special, 1 = check everything, 2 = uncheck everything')

    dictionary = relationship('Dictionary')
    templateQuestionCheckbox = relationship('TemplateQuestionCheckbox')


class TemplateQuestionLabelOption(Base):
    __tablename__ = 'templateQuestionLabelOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('templateQuestionLabel.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    posInitX = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posInitY = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posFinalX = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posFinalY = Column(INTEGER(11), nullable=False, server_default=text('0'))
    intensity = Column(INTEGER(11), nullable=False, server_default=text('0'))
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    templateQuestionLabel = relationship('TemplateQuestionLabel')

class TemplateQuestionRadioButtonOption(Base):
    __tablename__ = 'templateQuestionRadioButtonOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('templateQuestionRadioButton.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    templateQuestionRadioButton = relationship('TemplateQuestionRadioButton')


class TemplateQuestionTextBoxTrigger(Base):
    __tablename__ = 'templateQuestionTextBoxTrigger'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('templateQuestionTextBox.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    templateQuestionTextBox = relationship('TemplateQuestionTextBox')


class TextBox(Base):
    __tablename__ = 'textBox'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)

    question = relationship('Question')


class Time(Base):
    __tablename__ = 'time'

    ID = Column(BIGINT(20), primary_key=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)

    question = relationship('Question')


class Answer(Base):
    __tablename__ = 'answer'

    ID = Column(BIGINT(20), primary_key=True)
    questionnaireId = Column(ForeignKey('questionnaire.ID'), nullable=False, index=True)
    sectionId = Column(ForeignKey('section.ID'), nullable=False, index=True)
    questionId = Column(ForeignKey('question.ID'), nullable=False, index=True)
    typeId = Column(ForeignKey('type.ID'), nullable=False, index=True)
    answerSectionId = Column(ForeignKey('answerSection.ID'), nullable=False, index=True)
    languageId = Column(ForeignKey('language.ID'), nullable=False, index=True)
    patientId = Column(ForeignKey('patient.ID'), nullable=False, index=True)
    answered = Column(TINYINT(4), nullable=False, server_default=text('0'))
    skipped = Column(TINYINT(4), nullable=False, server_default=text('0'))
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    updatedBy = Column(String(255), nullable=False)

    answerSection = relationship('AnswerSection')
    language = relationship('Language')
    patient = relationship('Patient')
    question = relationship('Question')
    questionnaire = relationship('Questionnaire')
    section = relationship('Section')
    type = relationship('Type')


class CheckboxOption(Base):
    __tablename__ = 'checkboxOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('checkbox.ID'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    specialAction = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='0 = nothing special, 1 = check everything, 2 = uncheck everything')

    dictionary = relationship('Dictionary')
    checkbox = relationship('Checkbox')



class LabelOption(Base):
    __tablename__ = 'labelOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('label.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    posInitX = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posInitY = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posFinalX = Column(INTEGER(11), nullable=False, server_default=text('0'))
    posFinalY = Column(INTEGER(11), nullable=False, server_default=text('0'))
    intensity = Column(INTEGER(11), nullable=False, server_default=text('0'))
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    label = relationship('Label')


class RadioButtonOption(Base):
    __tablename__ = 'radioButtonOption'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('radioButton.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    radioButton = relationship('RadioButton')


class TextBoxTrigger(Base):
    __tablename__ = 'textBoxTrigger'

    ID = Column(BIGINT(20), primary_key=True)
    parentTableId = Column(ForeignKey('textBox.ID'), nullable=False, index=True)
    description = Column(ForeignKey('dictionary.contentId'), nullable=False, index=True)
    order = Column(INTEGER(11), nullable=False, server_default=text('1'))

    dictionary = relationship('Dictionary')
    textBox = relationship('TextBox')


class AnswerCheckbox(Base):
    __tablename__ = 'answerCheckbox'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(ForeignKey('checkboxOption.ID'), nullable=False, index=True)

    answer = relationship('Answer')
    checkboxOption = relationship('CheckboxOption')


class AnswerDate(Base):
    __tablename__ = 'answerDate'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(DateTime, nullable=False)

    answer = relationship('Answer')


class AnswerLabel(Base):
    __tablename__ = 'answerLabel'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    selected = Column(TINYINT(4), nullable=False, server_default=text('1'))
    posX = Column(INTEGER(11), nullable=False)
    posY = Column(INTEGER(11), nullable=False)
    intensity = Column(INTEGER(11), nullable=False)
    value = Column(ForeignKey('labelOption.ID'), nullable=False, index=True)

    answer = relationship('Answer')
    labelOption = relationship('LabelOption')


class AnswerRadioButton(Base):
    __tablename__ = 'answerRadioButton'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(ForeignKey('radioButtonOption.ID'), nullable=False, index=True)

    answer = relationship('Answer')
    radioButtonOption = relationship('RadioButtonOption')


class AnswerSlider(Base):
    __tablename__ = 'answerSlider'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(Float, nullable=False)

    answer = relationship('Answer')


class AnswerTextBox(Base):
    __tablename__ = 'answerTextBox'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(Text, nullable=False)

    answer = relationship('Answer')


class AnswerTime(Base):
    __tablename__ = 'answerTime'

    ID = Column(BIGINT(20), primary_key=True)
    answerId = Column(ForeignKey('answer.ID'), nullable=False, index=True)
    value = Column(DateTime, nullable=False)

    answer = relationship('Answer')
