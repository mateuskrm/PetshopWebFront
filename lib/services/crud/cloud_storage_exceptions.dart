

class CloudStorageException implements Exception{
  const CloudStorageException();
}

class CouldNotCreateException extends CloudStorageException{}
class CouldNotGetAllItemsException extends CloudStorageException{}
class CouldNotUpdateException extends CloudStorageException{}
class CouldNotDeleteException extends CloudStorageException{}